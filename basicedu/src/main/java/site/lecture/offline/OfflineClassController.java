package site.lecture.offline;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import site.member.Member;
import site.mypage.lecturer.offline.Offline;
import site.mypage.lecturer.offline.OfflineService;
import site.mypage.review.Review;
import site.util.PageUtil;
import site.util.Param;
import site.util.UserSessionUtil;

@Controller
@RequestMapping(value = "/offlineClass")
public class OfflineClassController {

	static Logger log = LoggerFactory.getLogger(OfflineService.class);

	@Resource(name = "OfflineService")
	OfflineService offlineService;

	@RequestMapping("/list")
	public String list(Offline offline, Model model, Param param) {

		param.setTotalRecordCount((int)offlineService.countClass());

		List<Offline> list = offlineService.offlineSelectAll(param);
//		param.setTarget("offlineClass");
//		param.setTotalRecordCount(list.size());

		model.addAttribute("offlecList", list);
		model.addAttribute("pagination", param);
		return "/lecture/offlec/offlecList";
	}

	@RequestMapping("/detail")
	public String detail(Offline offline, Model model, int offline_lecture_NO, HttpSession session) {
		Offline param = new Offline();
		param.setOffline_lecture_NO(offline_lecture_NO);
		int check = 0;
		String id = "";

		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd");
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format ( currentTime );

		model.addAttribute("curTime", mTime);

		Member member = (Member) session.getAttribute("userSession");
		if(member != null) {
			id = member.getId();

			OfflineApplication application = new OfflineApplication();
			application.setApplication_id(id);
			application.setOffline_lecture_NO(offline_lecture_NO);
			check = offlineService.offapplicationCheck(application);


		}

		Review review = new Review();
		review.setKeyNo(offline_lecture_NO);
		review.setKeySection("off");

		int nowPeople = offlineService.offlecnumberSumUser(offline_lecture_NO);

		int rejectPeople = offlineService.offlecnumberSumReject(offline_lecture_NO);

		int maxPeople = offlineService.offlineSelect(param).getOffline_lecture_max();

		log.debug("현재수강신청인원: " + nowPeople + "맥스: " + maxPeople);

		//log.debug("체크 : " + check);

		Member member2 = offlineService.SearchlecturerName(offlineService.offlineSelect(offline).getId());
		String img = offlineService.findImg(offlineService.offlineSelect(offline).getId());

		//log.debug("강사이름 : " + lecturer_Name);

		//log.debug("강사 아이디 " + offlineService.offlineSelect(offline).getId());
		//log.debug("강사 이미지" +  img);

		model.addAttribute("list", offlineService.replyList(review));
		model.addAttribute("reviewSize", offlineService.replyList(review).size());
		//log.debug("등록일자 :  " + offlineService.replyList(review).get(0).getRegister_Date() );
		model.addAttribute("rejectPeople", rejectPeople);
		model.addAttribute("id", id);
		model.addAttribute("check", check);
		model.addAttribute("nowPeople", nowPeople);
		model.addAttribute("maxPeople", maxPeople);
		model.addAttribute("member", member2);
		model.addAttribute("img", img);


		model.addAttribute("result", offlineService.offlineSelect(offline));
		return "/lecture/offlec/offlecDetail";

	}

	@RequestMapping("offlec_myApplication")
	public String offlec_myApplication(int application_no, int offline_lecture_NO, Model model) {

		Offline param = new Offline();
		param.setOffline_lecture_NO(offline_lecture_NO);

		int nowPeople = offlineService.offlecnumberSum(offline_lecture_NO);

		int maxPeople = offlineService.offlineSelect(param).getOffline_lecture_max();

		log.debug("맥스" + maxPeople + "나우" + nowPeople);

		model.addAttribute("nowPeople", nowPeople);
		model.addAttribute("maxPeople", maxPeople);
		model.addAttribute("list", offlineService.offaplicationSel(application_no));
		return "/lecture/offlec/offlecMyApplication";
	}

	@RequestMapping(value = "/offline_application", method = RequestMethod.POST)
	public String offline_application(Offline offline, Model model, HttpSession session) {
		// 로그인 id 받아오기
		if (!UserSessionUtil.isLogin()) {
			return "redirect:/member/login";
		}

		int offline_lecture_NO = offline.getOffline_lecture_NO();

		// 클래스 번호 받아오기
		Offline param = new Offline();
		param.setOffline_lecture_NO(offline_lecture_NO);

		int nowPeople = offlineService.offlecnumberSumUser(offline_lecture_NO);

		Offline offline1 = new Offline();

		offline1.setOffline_lecture_NO(offline_lecture_NO);

		int maxPeople = offlineService.offlineSelect(offline1).getOffline_lecture_max();

		model.addAttribute("nowPeople", nowPeople);
		model.addAttribute("maxPeople", maxPeople);
		model.addAttribute("result", param);

		return "/lecture/offlec/offlecApplication";
	}

	@RequestMapping(value = "/offlineapplicationadd", method = RequestMethod.POST)
	public void offlineapplicationadd(OfflineApplication application, Model model, HttpServletResponse response,
			HttpSession session) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			PageUtil.alertAndRedirect("redirect:/member/login", "로그인 후 사용 가능합니다.", response);
		};
		String id= user.getId();

		if (id != null) {
			application.setApplication_id(id);
		} else {
			PageUtil.alertAndRedirect("/member/login", "로그인 후 사용 가능", response);
		}

		application.setApplication_id(id);

		offlineService.offlineapplicationadd(application);

		PageUtil.alertAndRedirect("./list", "강의신청완료", response);
	}

	@RequestMapping(value = "/offlecSearch")
	public String offlecSearch(String searchCondition, String search_keyword, Offline offline, Model model, Param param) {



		if (searchCondition.equals("lecName")) {

			offline.setKeyword(search_keyword);
			param.setTotalRecordCount((int) offlineService.countNameclass(offline));

			param.setKeyword(search_keyword);
			List<Offline> list = offlineService.offlineSearchName(param);

			model.addAttribute("offlecList",list);
		}else {

			offline.setKeyword(search_keyword);
			param.setTotalRecordCount((int) offlineService.countCname(offline));

			param.setKeyword(search_keyword);
			List<Offline> list = offlineService.offlecSearch(param);
			model.addAttribute("offlecList", list);
		}
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("pagination", param);
		model.addAttribute("keyword", search_keyword);

		return "/lecture/offlec/offlecList";

	}

	@RequestMapping(value = "/myapplicationUpdate")
	public void myapplicationUpdate(OfflineApplication application, int application_no, HttpServletResponse response) {

		application.setApplication_no(application_no);
		offlineService.myapplicationUpdate(application);

		PageUtil.alertAndRedirect("./close", "수정성공", response);

	}

	@RequestMapping(value = "/myapplicationDelete")
	public void myapplicationDelete(int application_no, HttpServletResponse response) {
		offlineService.myapplicationDelete(application_no);
		PageUtil.alertAndRedirect("./close", "삭제성공", response);
	}

	@RequestMapping(value = "/close")
	public String close() {
		return "/mypage/offline/close";
	}

	@ResponseBody
	@RequestMapping(value = "/replyInsert", method = RequestMethod.POST)
	public void replyInsert(Review review, HttpSession session) {

		Member member = (Member) session.getAttribute("userSession");
		String id = member.getId();

		review.setKeySection("off");
		review.setId(id);
		offlineService.replyInsert(review);

	}
}
