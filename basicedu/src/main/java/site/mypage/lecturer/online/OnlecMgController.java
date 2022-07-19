package site.mypage.lecturer.online;

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
import site.lecture.online.OnlineClassService;
import site.member.Member;
import site.mypage.review.Review;
import site.mypage.review.ReviewService;
import site.util.PageUtil;
import site.util.Param;
import site.util.ThumbnailUtil;
import site.util.UserSessionUtil;


@Controller
@RequestMapping("/mypage/online")
public class OnlecMgController {

	static Logger log = LoggerFactory.getLogger(OnlecMgController.class);

	@Resource(name="OnlecMgService")
	OnlecMgService onlecMgService;

	@Value("#{prop['file.path']}")
	private String uploadPath;

	@Resource(name="ReviewService")
	ReviewService reviewService;

	@Resource(name="OnlineClassService")
	OnlineClassService onlineClassService;


	@RequestMapping("onlecmgList")
	public String onlecmgList(Model model, Param param) {

		// 강사 아이디로 조회
		Member user = UserSessionUtil.getUserSession();
		String id = user.getId();

		param.setId(id);
		param.setTotalRecordCount((int) onlecMgService.countLClass(param));

		List<OnlecMg> list = onlecMgService.selectLecturerAll(param);

		param.setTarget("onlinemgList");
		param.setTotalRecordCount(list.size());

		model.addAttribute("list", list);
		model.addAttribute("size", list.size());
		model.addAttribute("pagination", param);


		return "/lecture/onlec/onlecmgList";
	}

	@RequestMapping("onlecmgDetail")
	public String onlecmgDetail(@RequestParam("onlineLectureNo") int onlineLectureNo,
			Model model) {

		// 현재 아이디 조회
		Member user = UserSessionUtil.getUserSession();
		String id = user.getId();


		// 강의번호로 조회
		OnlecMg dto = onlecMgService.selectOne(onlineLectureNo);

		if (id.equals(dto.getLecturerId())) {

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


		}else {
			model.addAttribute("msg", "잘못된 접근입니다.");

		}

		return "/lecture/onlec/onlecmgDetail";


	}

	@RequestMapping("onlecDelete")
	public void onlecDelete(@RequestParam("onlineLectureNo") int onlineLectureNo,
			HttpServletResponse response) {

		// 현재 아이디 조회
		Member user = UserSessionUtil.getUserSession();
		String id = user.getId();


		// 삭제될 파일명 확인을 위한 셀렉트
		OnlecMg prevLecFiles = onlecMgService.selectOne(onlineLectureNo);

		if (id.equals(prevLecFiles.getLecturerId())) {

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
			PageUtil.alertAndRedirect("./onlecmgList", msg, response);

		}else {

			String msg = "잘못된 접근입니다.";
			PageUtil.alertAndRedirect("./onlecmgList", msg, response);

		}



	}

	@RequestMapping("onlecModify")
	public String onlecModify(@RequestParam("onlineLectureNo") int onlineLectureNo,
			Model model) {
		// 현재 아이디 조회
		Member user = UserSessionUtil.getUserSession();
		String id = user.getId();

		// 강의번호로 조회
		OnlecMg dto = onlecMgService.selectOne(onlineLectureNo);

		if (id.equals(dto.getLecturerId())) {

			List<OnlecMg> list = onlecMgService.selectOneVideo(onlineLectureNo);
			int videoQty = onlecMgService.videoCount(onlineLectureNo);

			model.addAttribute("lectureInfo", dto);
			model.addAttribute("videoList", list);
			model.addAttribute("videoQty", videoQty);

		}else {
			model.addAttribute("msg", "잘못된 접근입니다.");
		}


		return "/lecture/onlec/onlecmgModify";
	}

	@RequestMapping(value="onlecModifyPro", method=RequestMethod.POST)
	public void onlecModifyPro(OnlecMgCommand onlecMgCommand, Model model, HttpServletResponse response) {
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



		PageUtil.alertAndRedirect("./onlecmgDetail?onlineLectureNo="+num, msg, response);
	}




	@RequestMapping("onlecmgRegist")
	public String onlecmgRegist(@ModelAttribute(value="onlecMgCommand") OnlecMgCommand onlecMgCommand) {
		return "/lecture/onlec/onlecmgRegi";
	}



	@RequestMapping(value="onlecmgRegistPro", method=RequestMethod.POST)
	public void onlecmgRegistPro(OnlecMgCommand onlecMgCommand, HttpServletResponse response, Model model) {
		log.debug("controller");

		String msg = "등록이 완료되었습니다.";

		Member user = UserSessionUtil.getUserSession();
		String lecturerId = user.getId();

		OnlecMg dto = new OnlecMg();

		// ------- 강의 정보 및 파일 저장
		dto.setLecturerId(lecturerId);
		dto.setOnlineLectureName(onlecMgCommand.getOnlineLectureName());
		dto.setOnlineLectureInfo(onlecMgCommand.getOnlineLectureInfo());
		dto.setPrice(onlecMgCommand.getPrice());

		String filesStrTotal = "";
		String filesOrgTotal = "";



		for (MultipartFile multi : onlecMgCommand.getLectureFiles()) {


			String fileOrg = multi.getOriginalFilename();
			log.debug("multi file name : " + fileOrg);

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

		PageUtil.alertAndRedirect("./onlecmgList", msg, response);




	}



















}
































