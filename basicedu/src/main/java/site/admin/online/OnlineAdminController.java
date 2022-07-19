package site.admin.online;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import site.lecture.online.OnlineClass;
import site.lecture.online.OnlineClassCommand;
import site.lecture.online.OnlineClassService;
import site.member.Member;
import site.member.MemberService;
import site.mypage.lecturer.online.OnlecMg;
import site.mypage.lecturer.online.OnlecMgCommand;
import site.mypage.lecturer.online.OnlecMgService;
import site.mypage.review.Review;
import site.mypage.review.ReviewService;
import site.point.PointService;
import site.util.PageUtil;
import site.util.Param;
import site.util.ThumbnailUtil;

@Controller
@RequestMapping("/admin/online")
public class OnlineAdminController {

	static Logger log = LoggerFactory.getLogger(OnlineAdminController.class);

	@Resource(name = "OnlecMgService")
	OnlecMgService onlecMgService;

	@Resource(name = "PointService")
	PointService pointService;

	@Resource(name = "MemberService")
	MemberService memberService;

	@Resource(name = "OnlineClassService")
	OnlineClassService onlineClassService;

	@Resource(name = "ReviewService")
	ReviewService reviewService;

	@Value("#{prop['file.path']}")
	private String uploadPath;

	@RequestMapping("/list")
	public String list(Model model, Param param) {

		param.setTotalRecordCount((int) onlecMgService.countLClass(param));

		List<OnlecMg> list = onlecMgService.selectAll(param);

		model.addAttribute("list", list);
		model.addAttribute("size", list.size());
		model.addAttribute("pagination", param);

		return "/admin/online/onlineList";
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public String listPost(OnlineClassCommand command, Model model, Param param) {

		String condition = command.getCondition();
		String keyword = '%' + command.getKeyword() + '%';
		String searchInfo = "로 검색하신 결과입니다.";

		param.setKeyword(keyword);
		param.setSearchSe(condition);

		if (keyword != null) {

			param.setTotalRecordCount((int) onlecMgService.searchSelectCount(param));
			List<OnlecMg> searchList = onlecMgService.searchSelect(param);

			if (condition.equals("lecturerName")) {
				// 강사명으로 검색
				condition = "강사명";
			} else {
				// 강의명으로 검색
				condition = "클래스명";
			}

			param.setTarget("onlineClass");
			model.addAttribute("list", searchList);
			model.addAttribute("size", searchList.size());
			model.addAttribute("condition", condition);
			keyword = command.getKeyword();
			model.addAttribute("keyword", keyword);
			model.addAttribute("searchInfo", searchInfo);
			model.addAttribute("pagination", param);

		}

		return "/admin/online/onlineList";
	}

	@RequestMapping("/detail")
	public String detail(@RequestParam("onlineLectureNo") int onlineLectureNo, Model model) {

		// 강의번호로 조회
		OnlecMg dto = onlecMgService.selectOne(onlineLectureNo);
		List<OnlecMg> list = onlecMgService.selectOneVideo(onlineLectureNo);
		int videoQty = onlecMgService.videoCount(onlineLectureNo);

		// 후기 리스트 조회
		Review review = new Review();

		review.setKeyNo(onlineLectureNo);
		review.setKeySection("on");

		List<Review> reviewList = reviewService.findReviewList(review);

		if (reviewList.size() == 0) {
			reviewList = null;
		}

		// 수강신청 리스트 조회
		List<OnlineClass> classOrderList = onlineClassService.selectOrder(onlineLectureNo);
		if (classOrderList.size() != 0) {
			int qty = classOrderList.size();
			model.addAttribute("qty", qty);
		}

		model.addAttribute("lectureInfo", dto);
		model.addAttribute("videoList", list);
		model.addAttribute("videoQty", videoQty);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("classOrderList", classOrderList);
		model.addAttribute("size", classOrderList.size());

		return "/admin/online/onlineDetail";
	}

	@RequestMapping("/deleteReviews")
	public void deleteReviews(OnlineAdminCommand command, HttpServletResponse response) {

		int onlineLectureNo = command.getOnlineLectureNo();

		for (Integer rvn : command.getReviewNo()) {

			Review review = new Review();
			review.setId("admin");
			review.setReviewNo(rvn);

			reviewService.deleteReview(review);

		}

		String msg = "후기가 삭제되었습니다.";
		PageUtil.alertAndRedirect("./detail?onlineLectureNo="+onlineLectureNo, msg, response);
	}

	@RequestMapping("/lecturerSearch")
	public String lecturerSearch() {

		return "/admin/online/lecturerSearchPopup";
	}

	@RequestMapping(value="/lecturerSearch" , method=RequestMethod.POST)
	public String lecturerSearchPro(OnlineAdminCommand command,
			Model model, Param param) {

		String condition = command.getCondition();
		String keyword = command.getKeyword();

		if (keyword != null) {

			param.setKeyword(keyword);
			param.setSearchSe(condition);
			param.setMemberCategory("2");

			if (condition.equals("lecturerId")) {
				// 강사아이디로 검색
				param.setSearchSe("1");

			}else{
				// 강사명으로 검색
				param.setSearchSe("2");
			}

			param.setTotalRecordCount((int) memberService.countMember(param));
			List<Member> list = memberService.findMemberList(param);

			model.addAttribute("list", list);
			model.addAttribute("size", list.size());

		}

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", command.getKeyword());
		model.addAttribute("pagination", param);


		return "/admin/online/lecturerSearchPopup";
	}


	@RequestMapping("/regist")
	public String regist(@ModelAttribute(value="onlecMgCommand") OnlecMgCommand onlecMgCommand) {

		return "/admin/online/onlineRegist";
	}

	@RequestMapping("/registPro")
	public void registPro(OnlecMgCommand onlecMgCommand,
			HttpServletResponse response) {

		String msg = "등록이 완료되었습니다.";

		OnlecMg dto = new OnlecMg();

		// ------- 강의 정보 및 파일 저장
		dto.setLecturerId(onlecMgCommand.getLecturerId());
		dto.setOnlineLectureName(onlecMgCommand.getOnlineLectureName());
		dto.setOnlineLectureInfo(onlecMgCommand.getOnlineLectureInfo());
		dto.setPrice(onlecMgCommand.getPrice());

		String filesStrTotal = "";
		String filesOrgTotal = "";



		for (MultipartFile multi : onlecMgCommand.getLectureFiles()) {

			String fileOrg = multi.getOriginalFilename();
			System.out.println(fileOrg);

			if (fileOrg != "") {
				String originalFileExtension =
						fileOrg.substring(fileOrg.lastIndexOf("."));
				String fileStr = UUID.randomUUID().toString().replace("-", "")
						+originalFileExtension;
				filesOrgTotal += fileOrg + "`";
				filesStrTotal += fileStr + "`";

				File file = new File(uploadPath + "/onlec/" + fileStr);
				try {
					multi.transferTo(file);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}else {
				filesOrgTotal += "0`";
				filesStrTotal += "0`";
			}


		}

		if (filesOrgTotal != null && filesStrTotal != null) {

			String fileOrgName[] = filesOrgTotal.split("`");
			String fileStrName[] = filesStrTotal.split("`");

			ThumbnailUtil.thumbnailImg(uploadPath + "/onlec/", fileStrName[0]);

			dto.setImgFile(fileStrName[0]);

			if (!fileOrgName[1].equals("0")) {
				dto.setLibraryFileOrg(fileOrgName[1]);
			}
			if (!fileStrName[1].equals("0")) {
				dto.setLibraryFileStr(fileStrName[1]);
			}

			onlecMgService.registClass(dto);

			String videoStr = null;

			for (int i = 2; i < fileStrName.length; i++) {


				videoStr = fileStrName[i];

				if (videoStr != null && videoStr != "" && !videoStr.equals("0")) {

					dto.setVideoName(onlecMgCommand.getVideoName()[i-2]);
					dto.setVideoInfo(onlecMgCommand.getVideoInfo()[i-2]);
					dto.setVideoFile(videoStr);
					dto.setVideoFileOrg(fileOrgName[i]);
					dto.setChapterNo(i-1);

					onlecMgService.registVideo(dto);

				}

			}
		}






		PageUtil.alertAndRedirect("./list", msg, response);


	}

	@RequestMapping("modify")
	public String modify(@RequestParam("onlineLectureNo") int onlineLectureNo,
			Model model) {

		// 강의번호로 조회
		OnlecMg dto = onlecMgService.selectOne(onlineLectureNo);
		List<OnlecMg> list = onlecMgService.selectOneVideo(onlineLectureNo);
		int videoQty = onlecMgService.videoCount(onlineLectureNo);

		model.addAttribute("lectureInfo", dto);
		model.addAttribute("videoList", list);
		model.addAttribute("videoQty", videoQty);

		return "/admin/online/onlineModify";
	}

	@RequestMapping(value="modifyPro", method=RequestMethod.POST)
	public void modifyPro(OnlecMgCommand onlecMgCommand, Model model, HttpServletResponse response) {
		String msg = "수정이 완료되었습니다.";
		OnlecMg dto = new OnlecMg();
		int num = onlecMgCommand.getOnlineLectureNo();

		// ------- 강의 정보 및 파일 저장

		dto.setOnlineLectureName(onlecMgCommand.getOnlineLectureName());
		dto.setOnlineLectureInfo(onlecMgCommand.getOnlineLectureInfo());
		dto.setPrice(onlecMgCommand.getPrice());
		dto.setOnlineLectureNo(num);

		// 이전 파일 셀렉트
		OnlecMg prevLecFiles = onlecMgService.selectOne(num);
		List<OnlecMg> prevVideoFiles = onlecMgService.selectOneVideo(num);
		String imgFileStr = prevLecFiles.getImgFile();
		String libFileOrg = prevLecFiles.getLibraryFileOrg();
		String libFileStr = prevLecFiles.getLibraryFileStr();

		String filesStrTotal = "";
		String filesOrgTotal = "";


		for (MultipartFile multi : onlecMgCommand.getLectureFiles()) {

			String fileOrg = multi.getOriginalFilename();

			if (fileOrg != "") {
				String originalFileExtension =
						fileOrg.substring(fileOrg.lastIndexOf("."));
				String fileStr = UUID.randomUUID().toString().replace("-", "")
						+originalFileExtension;

				filesOrgTotal += fileOrg + "`";
				filesStrTotal += fileStr + "`";

				File file = new File(uploadPath + "/onlec/" + fileStr);

				try {
					multi.transferTo(file);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}else {
				filesOrgTotal += "0`";
				filesStrTotal += "0`";
			}

		}

		if (filesOrgTotal != null && filesStrTotal != null) {
			String fileOrgName[] = filesOrgTotal.split("`");
			String fileStrName[] = filesStrTotal.split("`");

			dto.setImgFile(fileStrName[0]);
			dto.setLibraryFileOrg(fileOrgName[1]);
			dto.setLibraryFileStr(fileStrName[1]);

			if (fileOrgName[0].equals("0")) {
				dto.setImgFile(imgFileStr);
			}

			if (fileOrgName[1].equals("0") ) {
				if(libFileOrg != null) {
					dto.setLibraryFileOrg(libFileOrg);
					dto.setLibraryFileStr(libFileStr);
				}else {
					dto.setLibraryFileOrg(null);
					dto.setLibraryFileStr(null);
				}

			}


			// 수정 정보 업데이트
			int updateClass = onlecMgService.updateClass(dto);


			// 파일 삭제
			if (updateClass > 0) {

				if(!fileOrgName[0].equals("0")) {

					ThumbnailUtil.thumbnailImg(uploadPath + "/onlec/", fileStrName[0]);
					File fileDel = new File(uploadPath + "/onlec/" + imgFileStr);
					if (fileDel.exists()) {
						fileDel.delete();
						log.debug("대표이미지 삭제 성공");

					}
				}
				if(!fileOrgName[1].equals("0")) {
					File fileDel = new File(uploadPath + "/onlec/" + libFileStr);
					if (fileDel.exists()) {
						fileDel.delete();
						log.debug("수업자료 삭제 성공");

					}
				}


			}

			// 영상 정보 업데이트

			for (int i = 2; i < fileOrgName.length; i++) {

				String prevVideo = prevVideoFiles.get(i-2).getVideoFile();
				String prveVideoOrg = prevVideoFiles.get(i-2).getVideoFileOrg();

				String videoStr = fileStrName[i];
				String videoOrg = fileOrgName[i];

				dto.setVideoName(onlecMgCommand.getVideoName()[i-2]);
				dto.setVideoInfo(onlecMgCommand.getVideoInfo()[i-2]);
				dto.setVideoFile(videoStr);
				dto.setVideoFileOrg(videoOrg);
				dto.setChapterNo(i-1);

				if (fileOrgName[i].equals("0")) {
					dto.setVideoFile(prevVideo);
					dto.setVideoFileOrg(prveVideoOrg);
				}

				int updateVideo = onlecMgService.updatVideo(dto);

				// 영상 삭제
				if (updateVideo > 0) {

					if(!fileOrgName[i].equals("0")) {

						File fileDel = new File(uploadPath + "/onlec/" + prevVideo);
						if (fileDel.exists()) {
							fileDel.delete();
							log.debug("비디오 삭제 성공");

						}
					}
				}
			}
		}








		PageUtil.alertAndRedirect("./detail?onlineLectureNo="+num, msg, response);
	}

	@RequestMapping("delete")
	public void onlecDelete(@RequestParam("onlineLectureNo") int onlineLectureNo,
			HttpServletResponse response) {

		// 삭제될 파일명 확인을 위한 셀렉트
		OnlecMg prevLecFiles = onlecMgService.selectOne(onlineLectureNo);
		List<OnlecMg> prevVideoFiles = onlecMgService.selectOneVideo(onlineLectureNo);
		int videoQty = onlecMgService.videoCount(onlineLectureNo);

		String[] strFile = new String[2];
		String[] strVideoFile = new String[videoQty];

		if (prevLecFiles.getImgFile() != null) {
			strFile[0] = prevLecFiles.getImgFile();
		}
		if (prevLecFiles.getLibraryFileStr() != null) {
			strFile[1] = prevLecFiles.getLibraryFileStr();
		}


		int delVideo = onlecMgService.deleteVideo(onlineLectureNo);
		int delClass = onlecMgService.deleteClass(onlineLectureNo);



		// 강의 및 비디오 정보가 삭제되었을 때 관련 파일 삭제
		if (delClass>0 && delVideo>0 ) {

			if (strFile != null) {

				for (String str : strFile) {
					File fileDel = new File(uploadPath + "/onlec/" + str);
					if (fileDel.exists()) {
						fileDel.delete();
						log.debug("강의 첨부파일 삭제 성공");
					}
				}

			}
			if (strVideoFile != null) {

				for (int i = 0; i < videoQty; i++) {
					strVideoFile[i] = prevVideoFiles.get(i).getVideoFile();
					for (String str : strVideoFile) {
						File fileDel = new File(uploadPath + "/onlec/" + str);
						if (fileDel.exists()) {
							fileDel.delete();
							log.debug("비디오파일 삭제 성공");
						}

					}

				}


			}


		}

		String msg = "삭제가 완료되었습니다.";

		PageUtil.alertAndRedirect("./list", msg, response);


	}

}
