package site.mypage.lecturer.offline;

import java.io.File;

import java.text.SimpleDateFormat;
import java.util.Date;import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import site.lecture.offline.OfflineApplication;
import site.member.Member;
import site.util.PageUtil;
import site.util.Param;
import site.util.ThumbnailUtil;
import site.util.UserSessionUtil;

@Controller
@RequestMapping("/mypage/offline")
public class OfflineController {

	static Logger log = LoggerFactory.getLogger(OfflineService.class);

	@Resource(name = "OfflineService")
	OfflineService offlineService;

	@Value("#{prop['file.path']}")
	private String uploadPath;

	@RequestMapping("list")
	public String list(Offline offline, Model model, HttpSession session, HttpServletRequest request, Param param) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}

		Member member=(Member) session.getAttribute("userSession");
		String id = member.getId();
		offline.setId(id);

		param.setTotalRecordCount((int) offlineService.countmyclass(id));

		param.setId(id);

		List<Offline> list = offlineService.offlineList(param);


		log.debug("로그인 " + id );

		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");

		Date time = new Date();

		String curTime = format1.format(time);

		model.addAttribute("curTime", curTime);
		model.addAttribute("size", list.size());
		model.addAttribute("pagination", param);
		model.addAttribute("list", list);
		return "/mypage/offline/list";
	}

	@RequestMapping(value = "offlineSelect")
	public String offlineSelect(Offline offline, Model model, int offline_lecture_NO) {
		Offline param = new Offline();
		param.setOffline_lecture_NO(offline_lecture_NO);
		model.addAttribute("result", offlineService.offlineSelect(offline));
		return "/mypage/offline/offlineSelect";
	}

	@RequestMapping("offlineDetailSelect")
	public String offlineDetailSelect(Offline offline, Model model, int offline_lecture_NO,HttpSession session) {

		Member member=(Member) session.getAttribute("userSession");
		String id = member.getId();
		offline.setId(id);
		offline.setOffline_lecture_NO(offline_lecture_NO);
		List<Offline> list = offlineService.offlineList2(offline);
		int cnt = 0;

		// 현재 아이디의 강의리스토와 url로 넘어온 offline_lecture_NO와 비교
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getOffline_lecture_NO()== offline_lecture_NO) {
				cnt++;
			}

		}
		log.debug("cnt         " + cnt);
		if(cnt>0) {
			model.addAttribute("result", offlineService.offlineSelect(offline));
			return "mypage/offline/offlineDetailSelect";
		}else {
			model.addAttribute("msg","잘못된 접근입니다.");
			model.addAttribute("url", "/mypage/offline/list");
			return "/mypage/offline/redirect";
		}
	}

	@RequestMapping("redirect")
	public String redirect() {
		return "/mypage/offline/redirect";
	}

	@RequestMapping("offlineApplication")
	public String offlineApplication(Offline offline, Model model) {
		return "/mypage/offline/offlineApplication";
	}

	@RequestMapping(value = "offlineJoin")
	public String offlineJoin(Offline offline, Model model) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}

		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");

		Date time = new Date();

		String curTime = format1.format(time);

		model.addAttribute("curTime", curTime);

		log.debug("offlineController");
		return "/mypage/offline/offlineJoin";
	}

	@RequestMapping(value = "offlineJoinadd", method = RequestMethod.POST)
	public void offlineJoin(Offline offline, Model model, HttpServletResponse response,
			@RequestParam(value = "offlineImg") MultipartFile multipart, HttpSession session) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String time = sdf.format(new Date());
		String fileName = "";
		Member member= (Member) session.getAttribute("userSession");

		String id = member.getId();

		if(id != null) {
			offline.setId(id);
		}else {
			PageUtil.alertAndRedirect("/member/login", "로그인 후 이용해 주세요", response);
		}

		log.debug(multipart.getName() + " : " + multipart.getOriginalFilename() + ", " + multipart.getContentType());

		try {
			log.debug(
					multipart.getName() + " : " + multipart.getOriginalFilename() + ", " + multipart.getContentType());

			fileName = time + "_" + multipart.getOriginalFilename();
			File file = new File(uploadPath + "/offline/" + fileName);
			multipart.transferTo(file);

			if ("offlineImg".equals(multipart.getName())) {
				offline.setOffline_lecture_img(fileName);
				ThumbnailUtil.thumbnailImg(uploadPath + "/offline/", fileName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		log.debug("offlineController");
		offlineService.offlineJoinadd(offline);

		PageUtil.alertAndRedirect("./list", "강의등록완료", response);

	}

	@RequestMapping("offlineDelete")
	public void offlinedelete(HttpServletRequest request, HttpServletResponse response) {
		int offline_lecture_NO = Integer.parseInt(request.getParameter("offline_lecture_NO"));
		String preFile = offlineService.fileSearch(offline_lecture_NO);

		// 메인 이미지
		File main = new File(uploadPath + "/offline/" + preFile);
		// 썸네일 이미지
		File thumb = new File(uploadPath + "/offline/thumb/" + preFile);

		if (main.exists()) {
			main.delete();
			thumb.delete();
		}
		Offline param = new Offline();
		param.setOffline_lecture_NO(offline_lecture_NO);
		offlineService.offlineDelete(param);
		PageUtil.alertAndRedirect("./list", "삭제되었습니다.", response);

	}

	@RequestMapping(value = "offlineUpdate", method = RequestMethod.POST)
	public void offlineUpdate(Offline offline, Model model, HttpServletResponse response, HttpServletRequest request,
			@RequestParam(value = "offlineImg") MultipartFile multipart) {

		int no = Integer.parseInt(request.getParameter("offline_lecture_NO"));

		String preFile = offlineService.fileSearch(no);

		File main = new File(uploadPath + "/offline/" + preFile);
		File thumb = new File(uploadPath + "/offline/thumb/" + preFile);

		if (main.exists()) {
			main.delete();
			thumb.delete();

		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String time = sdf.format(new Date());
		String fileName = "";
		log.debug(multipart.getName() + " : " + multipart.getOriginalFilename() + ", " + multipart.getContentType());

		try {
			log.debug(
					multipart.getName() + " : " + multipart.getOriginalFilename() + ", " + multipart.getContentType());

			fileName = time + "_" + multipart.getOriginalFilename();
			File file = new File(uploadPath + "/offline/" + fileName);
			multipart.transferTo(file);

			if ("offlineImg".equals(multipart.getName())) {
				offline.setOffline_lecture_img(fileName);
				ThumbnailUtil.thumbnailImg(uploadPath + "/offline/", fileName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}


		offline.setOffline_lecture_NO(no);

		offlineService.offlineUpdate(offline);

		PageUtil.alertAndRedirect("./list", "수정성공", response);
	}

	@RequestMapping(value = "offlineUpdate1", method = RequestMethod.POST)
	public void offlineUpdate1(Offline offline, Model model, HttpServletResponse response, HttpServletRequest request) {

		int no = Integer.parseInt(request.getParameter("offline_lecture_NO"));

		offline.setOffline_lecture_NO(no);

		offlineService.offlineUpdate1(offline);

		PageUtil.alertAndRedirect("./list", "수정성공", response);
	}

	@RequestMapping(value = "/applicationList")
	public String offapplicationList(OfflineApplication application, Model model,int offline_lecture_NO, Param param2) {
		OfflineApplication param = new OfflineApplication();
		param.setOffline_lecture_NO(offline_lecture_NO);

		int nowPeople = offlineService.offlecnumberSum(offline_lecture_NO);

		Offline offline = new Offline();

		offline.setOffline_lecture_NO(offline_lecture_NO);

		int maxPeople = offlineService.offlineSelect(offline).getOffline_lecture_max();

		param2.setTotalRecordCount((int) offlineService.applicationListCount(offline_lecture_NO));
		param2.setKeyNo(offline_lecture_NO);
		List<OfflineApplication> list = offlineService.offapplicationList(param2);


		model.addAttribute("pagination", param2);
		model.addAttribute("nowPeople", nowPeople);
		model.addAttribute("maxPeople",maxPeople);
		model.addAttribute("list", list);
		model.addAttribute("size", list.size());

		return "/mypage/offline/offapliList";
	}

	@RequestMapping(value="/offapli_detail")
	public String offapli_detail(int application_no,Model model) {


		model.addAttribute("list",offlineService.offaplicationSel(application_no));
		return "/mypage/offline/offapliDetail";
	}

	//신청서 승인
	@RequestMapping(value = "/offaplicationOk")
	public void offaplicationOk(OfflineApplication application,int application_no, HttpServletResponse response) {
		application.setApplication_no(application_no);
		application.setApplication_status(1);

		log.debug("승인"+ application.getApplication_no(), application.getApplication_status());
		offlineService.offaplicationApproval(application);

		PageUtil.alertAndRedirect("./close", "승인완료", response);

	}

	@RequestMapping(value = "/offaplicationReject")
	public void offaplicationReject(OfflineApplication application,int application_no, HttpServletResponse response) {
		application.setApplication_no(application_no);
		application.setApplication_status(2);

		offlineService.offaplicationApproval(application);

		PageUtil.alertAndRedirect("./close", "거절완료", response);
	}

	@RequestMapping(value = "/close")
	public String close() {
		return "/mypage/offline/close";
	}

	@RequestMapping(value = "/offlineMylecture")
	public String offlineMylecture(HttpSession session,Model model, Param param){

		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}

		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd");
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format ( currentTime );
		log.debug(mTime);

		Member member= (Member) session.getAttribute("userSession");
		String id = member.getId();

		param.setTotalRecordCount((int) offlineService.myLectureCount(id));
		param.setId(id);

		List<Offline> list = offlineService.offlineMylecture(param);

		model.addAttribute("pagination", param);
		model.addAttribute("curTime", mTime);
		model.addAttribute("list", list);
		model.addAttribute("size", list.size());


		return "/mypage/offline/myofflec";
	}

}
