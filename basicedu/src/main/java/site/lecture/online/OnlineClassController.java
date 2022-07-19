package site.lecture.online;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import site.member.Member;
import site.member.MemberService;
import site.mypage.lecturer.online.OnlecMg;
import site.mypage.lecturer.online.OnlecMgService;
import site.mypage.review.Review;
import site.mypage.review.ReviewService;
import site.order.OrderService;
import site.order.Payment;
import site.point.Point;
import site.point.PointService;
import site.util.AES256Util;
import site.util.PageUtil;
import site.util.Param;
import site.util.UserSessionUtil;


@Controller
@RequestMapping(value = "/onlineClass")
public class OnlineClassController {

	static Logger log = LoggerFactory.getLogger(OnlineClassController.class);

	@Resource(name="OnlecMgService")
	OnlecMgService onlecMgService;

	@Resource(name="PointService")
	PointService pointService;

	@Resource(name="MemberService")
	MemberService memberService;

	@Resource(name="OnlineClassService")
	OnlineClassService onlineClassService;

	@Resource(name="ReviewService")
	ReviewService reviewService;

	@Resource(name="OrderService")
	OrderService orderService;

	public AES256Util AES256 = new AES256Util();

	@RequestMapping(value="/list", method = RequestMethod.GET)
	public String list(Model model, Param param) {


		param.setTotalRecordCount((int) onlecMgService.countLClass(param));

		List<OnlecMg> list = onlecMgService.selectAll(param);

		model.addAttribute("onlecList", list);
		model.addAttribute("pagination", param);

		return "/lecture/onlec/onlecList";
	}

	@RequestMapping(value="/list", method = RequestMethod.POST)
	public String listPost(OnlineClassCommand command, Model model, Param param) {
		String condition = command.getCondition();
		String keyword = '%'+command.getKeyword()+'%';
		String searchInfo = "로 검색하신 결과입니다.";
		param.setKeyword(keyword);

		if (keyword != null) {



			if (condition.equals("lecturerName")) {
				// 강사명으로 검색
				condition = "강사명";
				param.setSearchSe("lecturerName");
			} else {
				// 강의명으로 검색
				condition = "클래스명";
				param.setSearchSe("className");
			}

			param.setTotalRecordCount((int) onlecMgService.searchSelectCount(param));
			List<OnlecMg> searchList = onlecMgService.searchSelect(param);

			param.setTarget("onlineClass");
			model.addAttribute("onlecList", searchList);
			model.addAttribute("size", searchList.size());
			model.addAttribute("condition", condition);
			keyword = command.getKeyword();
			model.addAttribute("keyword", keyword);
			model.addAttribute("searchInfo", searchInfo);
			model.addAttribute("pagination", param);

		}

		return "/lecture/onlec/onlecList";
	}


	@RequestMapping(value="/lecturerList")
	public String lecturerList(@RequestParam(value="id") String id, @RequestParam(value="name") String name,
			Model model, Param param) {

		param.setId(id);
		param.setTotalRecordCount((int) onlecMgService.countLClass(param));

		List<OnlecMg> list = onlecMgService.selectLecturerAll(param);

		model.addAttribute("onlecList", list);
		model.addAttribute("lname", name);
		model.addAttribute("pagination", param);

		return "/lecture/onlec/onlecList";
	}


	@RequestMapping("/detail")
	public String detail(@RequestParam("onlineLectureNo") int onlineLectureNo,
			Model model) {

		OnlecMg dto = onlecMgService.selectOne(onlineLectureNo);
		List<OnlecMg> list = onlecMgService.selectOneVideo(onlineLectureNo);
		int videoQty = onlecMgService.videoCount(onlineLectureNo);

		Member user = UserSessionUtil.getUserSession();


		if (user != null) {

			String id = user.getId();
			model.addAttribute("nowId", id);

			OnlineClass my = new OnlineClass();
			my.setId(id);
			my.setOnlineLectureNo(onlineLectureNo);
			my.setOnlineOrderNo(0);


			OnlineClass isMy = onlineClassService.selectMyClassOne(my);

			if (isMy != null) {
				model.addAttribute("isMy", "리뷰 권한 있음");
			}

		}

		Review review = new Review();

		review.setKeyNo(onlineLectureNo);
		review.setKeySection("on");

		List<Review> reviewList = reviewService.findReviewList(review);

		if (reviewList.size() == 0) {
			reviewList = null;
		}
		model.addAttribute("reviewList", reviewList);



		model.addAttribute("lectureInfo", dto);
		model.addAttribute("videoList", list);
		model.addAttribute("videoQty", videoQty);

		return "/lecture/onlec/onlecDetail";
	}

	@RequestMapping("/apply")
	public String apply(@RequestParam("onlineLectureNo") int onlineLectureNo,
			Model model) {



		OnlecMg dto = onlecMgService.selectOne(onlineLectureNo);
		int videoQty = onlecMgService.videoCount(onlineLectureNo);

		Member user = UserSessionUtil.getUserSession();

		//가져온 개인정보 복호화
		if (user.getAddress() != null) {
			String address = AES256.decrypt(user.getAddress());
			user.setAddress(address);
		}
		if (user.getPhoneNumber() != null) {
			String phoneNumber = AES256.decrypt(user.getPhoneNumber());
			user.setPhoneNumber(phoneNumber);
		}
		if (user.getEmail() !=null) {
			String email = AES256.decrypt(user.getEmail());
			user.setEmail(email);
		}

		model.addAttribute("user", user);

		OnlineClass my = new OnlineClass();
		my.setId(user.getId());
		my.setOnlineLectureNo(onlineLectureNo);
		my.setOnlineOrderNo(0);

		OnlineClass isMy = onlineClassService.selectMyClassOne(my);

		if (isMy == null ) {

			Integer point = memberService.nowPoint(user.getId());
			if (point == null) {
				point = 0;
			}

			model.addAttribute("lectureInfo", dto);
			model.addAttribute("videoQty", videoQty);
			model.addAttribute("point", point);


			return "/lecture/onlec/onlecApply";
		}else {
			model.addAttribute("status", "이미 수강중인 강의");
			return "redirect:/onlineClass/detail?onlineLectureNo="+onlineLectureNo;
		}




	}

	@RequestMapping("/applyPro")
	public void applyPro(OnlineClassCommand command, Payment payment, HttpServletResponse response) {

		String msg = "온라인 강의 수강신청이 완료되었습니다.";

		Member user = UserSessionUtil.getUserSession();
		int onlineLectureNo = command.getOnlineLectureNo();

		// 결제정보 저장
		orderService.savePayment(payment);
		String paymentNo = payment.getPaymentNo();

		// 온라인 강의 수강신청 정보 저장
		OnlineClass dto = new OnlineClass();
		String id = user.getId();
		dto.setId(id);
		dto.setOnlineLectureNo(onlineLectureNo);
		dto.setPaymentNo(paymentNo);

		onlineClassService.applyClass(dto);

		// 온라인 강의 진도 테이블에 정보 저장
		// 비디오 번호 가져오기
		List<OnlecMg> videos = onlecMgService.selectOneVideo(onlineLectureNo);
		// 온라인 강의 신청 번호 가져오기
		int onlineOrderNo = onlineClassService.selectOrderNo(paymentNo);
		OnlineClass videoDto = new OnlineClass();
		videoDto.setOnlineLectureNo(onlineLectureNo);
		videoDto.setOnlineOrderNo(onlineOrderNo);
		for (int i = 0; i < videos.size(); i++) {
			videoDto.setVideoNo(videos.get(i).getVideoNo());
			onlineClassService.createMyProgress(videoDto);
		}

		// 회원 정보에 현재 포인트 업데이트 및 포인트 내역 저장
		int prevPoint = user.getPoint();

		log.debug("prevPoint : "+ prevPoint);

		Integer usePoint = command.getPoint();
		if(usePoint == null) {
			usePoint = 0;
		}


		if (usePoint !=0){
			log.debug("usePoint : "+ usePoint);

			int nowPoint = (prevPoint)-(usePoint);

			log.debug("nowPoint : "+ nowPoint);
			user.setPoint(nowPoint);

			// 회원 정보에 현재 포인트 업데이트
			memberService.updatePoint(user);

			// 포인트 히스토리 저장
			String contents = "포인트 사용(온라인클래스 구매)";
			usePoint = -(command.getPoint());

			log.debug("point 테이블에 저장될 usePoint : "+ usePoint);
			Point point = new Point();
			point.setId(id);
			point.setContents(contents);
			point.setPoint(usePoint);
			pointService.insertHistory(point);
		}


		PageUtil.alertAndRedirect("./list", msg, response);
	}

	@RequestMapping("/reviewDelete")
	public void reviewDelete(@RequestParam("reviewNo")int reviewNo,
			@RequestParam("onlineLectureNo") int onlineLectureNo, HttpServletResponse response) {

		Member user = UserSessionUtil.getUserSession();

		Review review = new Review();
		review.setId(user.getId());
		review.setReviewNo(reviewNo);

		reviewService.deleteReview(review);

		String msg = "후기가 삭제되었습니다.";

		PageUtil.alertAndRedirect("./detail?onlineLectureNo="+onlineLectureNo, msg, response);



	}




}
