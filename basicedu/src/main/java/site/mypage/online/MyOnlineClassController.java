package site.mypage.online;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.lecture.online.OnlineClass;
import site.lecture.online.OnlineClassService;
import site.member.Member;
import site.member.MemberService;
import site.mypage.lecturer.online.OnlecMg;
import site.mypage.lecturer.online.OnlecMgService;
import site.mypage.review.Review;
import site.mypage.review.ReviewService;
import site.point.Point;
import site.point.PointService;
import site.util.PageUtil;
import site.util.Param;
import site.util.UserSessionUtil;

@Controller
@RequestMapping("/mypage/online")
public class MyOnlineClassController {

	static Logger log = LoggerFactory.getLogger(MyOnlineClassController.class);

	@Resource(name="OnlineClassService")
	OnlineClassService onlineClassService;

	@Resource(name="OnlecMgService")
	OnlecMgService onlecMgService;

	@Resource(name="ReviewService")
	ReviewService reviewService;

	@Resource(name="MemberService")
	MemberService memberService;

	@Resource(name="PointService")
	PointService pointService;

	@RequestMapping("myOnlineClass")
	public String myOnlineClass(Model model, Param param) {


		Member user = UserSessionUtil.getUserSession();
		String id = user.getId();

		param.setId(id);
		param.setTotalRecordCount((int) onlineClassService.countApplyClass(param));
		System.out.println(param.getTotalRecordCount());
		List<OnlineClass> list = onlineClassService.selectMyClass(param);

		param.setTarget("myOnlineClass");
		param.setTotalRecordCount(list.size());

		model.addAttribute("list", list);
		model.addAttribute("size", list.size());
		model.addAttribute("pagination", param);


		return "/lecture/onlec/myOnlineList";
	}

	@RequestMapping("pointBack")
	public void pointBack(@RequestParam(value="onlineOrderNo") int onlineOrderNo,
			@RequestParam(value="point") int point,
			HttpSession session, HttpServletResponse response) {



		int pointp = (int) (point*0.1);
		String msg = pointp + "포인트가 환급되었습니다.";

		Member user = UserSessionUtil.getUserSession();
		String id = user.getId();

		int nowPoint = memberService.nowPoint(id);

		int updatePoint = nowPoint + pointp;

		Member dto = new Member();
		dto.setId(id);
		dto.setPoint(updatePoint);

		memberService.updatePoint(dto);

		// 포인트 히스토리 저장
		String contents = "포인트 환급(온라인클래스 수강 완료)";
		Point ph = new Point();
		ph.setId(id);
		ph.setContents(contents);
		ph.setPoint(pointp);
		pointService.insertHistory(ph);

		// 강의 신청 테이블에 포인트 환급 여부 업데이트
		onlineClassService.updatePointBack(onlineOrderNo);

		PageUtil.alertAndRedirect("./myOnlineClass", msg, response);



	}


	@RequestMapping("myOnlineDetail")
	public String myOnlineClass(@RequestParam(value="onlineLectureNo") int onlineLectureNo,
			@RequestParam(value="onlineOrderNo") int onlineOrderNo,
			Model model, HttpSession session) {

		Member member = new Member();
		member = (Member) session.getAttribute("userSession");
		String id = member.getId();

		OnlineClass my = new OnlineClass();
		my.setId(id);
		my.setOnlineLectureNo(onlineLectureNo);
		my.setOnlineOrderNo(onlineOrderNo);
		OnlineClass myclass = onlineClassService.selectMyClassOne(my);

		OnlecMg classInfo = onlecMgService.selectOne(onlineLectureNo);
		List<OnlecMg> video = onlecMgService.selectOneVideo(onlineLectureNo);
		int videoQty = onlecMgService.videoCount(onlineLectureNo);

		model.addAttribute("myclass", myclass);
		model.addAttribute("classInfo", classInfo);
		model.addAttribute("video", video);
		model.addAttribute("videoQty", videoQty);

		return "/lecture/onlec/myOnlineDetail";
	}

	@RequestMapping("myOnlineVideo")
	public String myOnlineVideo(@RequestParam(value="onlineLectureNo") int onlineLectureNo,
			@RequestParam(value = "videoNo") int videoNo, @RequestParam(value = "nowVideo") int nowVideo,
			@RequestParam(value="onlineOrderNo") int onlineOrderNo, Model model, HttpSession session) throws IOException {

		Member user = UserSessionUtil.getUserSession();
		String id = user.getId();

		OnlineClass my = new OnlineClass();
		my.setId(id);
		my.setOnlineLectureNo(onlineLectureNo);
		my.setOnlineOrderNo(onlineOrderNo);
		OnlineClass myclass = onlineClassService.selectMyClassOne(my);

		if (id.equals(myclass.getId())) {

			List<OnlecMg> videos = onlecMgService.selectOneVideo(onlineLectureNo);
			OnlecMg video = onlecMgService.selectOneVideoNo(videoNo);
			int videoQty = onlecMgService.videoCount(onlineLectureNo);

			model.addAttribute("videos", videos);
			model.addAttribute("video", video);
			model.addAttribute("videoQty", videoQty);
			model.addAttribute("nowVideo", nowVideo);
			model.addAttribute("onlineOrderNo", onlineOrderNo);

		}else {
			model.addAttribute("msg", "잘못된 접근입니다.");
		}

		return "/lecture/onlec/myOnlineVideo";
	}

	@RequestMapping("/player/{filename}")
	public void player (@PathVariable String filename, Model model,
			HttpServletRequest request, HttpServletResponse response) throws IOException {

		StreamView.renderMergedOutputModel(filename, request, response);
	}


	@RequestMapping("myOnlineReview")
	public void myOnlineReview(MyOnlineClassCommand command, HttpServletResponse response) {

		String msg = "클래스 리뷰가 등록되었습니다.";

		Member user = UserSessionUtil.getUserSession();
		String id = user.getId();

		Review review = new Review();

		System.out.println(command.toString());

		review.setId(id);
		review.setKeyNo(command.getOnlineLectureNo());
		review.setKeySection("on"); // 상품/강의 구분 (OFF:오프라인강의 ON:온라인강의 P:상품)
		review.setContents(command.getOnlineReview());

		reviewService.saveReview(review);

		int num = command.getOnlineLectureNo();


		PageUtil.alertAndRedirect("/onlineClass/detail?onlineLectureNo="+num, msg, response);

	}

	@RequestMapping("runtime")
	public void runtime(@RequestParam("onlineLectureNo") int onlineLectureNo,
			@RequestParam("nowVideo") int nowVideo,
			@RequestParam("onlineOrderNo") int onlineOrderNo,
			@RequestParam("duration") String duration,
			@RequestParam("current") String current,
			HttpSession session, HttpServletResponse response) {

		Member user = UserSessionUtil.getUserSession();
		String id = user.getId();

		OnlineClass my = new OnlineClass();
		my.setId(id);
		my.setOnlineLectureNo(onlineLectureNo);
		my.setOnlineOrderNo(onlineOrderNo);


		// 이전 해당 수업 진도율 조회
		my.setVideoNo(nowVideo);
		OnlineClass now = onlineClassService.selectNowVideo(my);

		int prvRunTime= now.getRuntime();
		System.out.println("이전 해당 비디오 진도율: "+prvRunTime);


		// 현재 수업 영상 진도율 구하기
		double durationTime = Double.parseDouble(duration);
		double currentTime = Double.parseDouble(current);
		double runtime = currentTime / durationTime * 100;
		int nowRuntime =  (int) Math.round(runtime);


		// 이전 진도율이 더 크면 현재 진행률을 더해주고
		// 이전 진도율과 같거나 더 크면 현재 진행률을 그대로 업데이트
		int hap;
		if (prvRunTime >= nowRuntime) {
			hap = prvRunTime+nowRuntime;
			System.out.println("1"+hap);
			if (hap > 100) {
				hap = 100;
			}
		}else {
			hap = nowRuntime;
			System.out.println("2"+hap);
		}

		// 해당 수업 진도율 업데이트
		my.setRuntime(hap);
		System.out.println("*업데이트할 해당 비디오 진도율: "+hap);

		onlineClassService.updateRuntimeEach(my);

		// 총 진행률 신청정보에 업데이트
		// 모든 진도율 가져오기
		List<OnlineClass> progress = onlineClassService.selectMyProgress(onlineOrderNo);

		int proHap=0;
		int size=progress.size();

		for (int i = 0; i < size; i++) {
			proHap += progress.get(i).getRuntime();
			System.out.println("각 비디오 진도율"+i+": "+ progress.get(i).getRuntime());

		}
		System.out.println("각 비디오 진도율 합: "+ proHap);

		double avg = proHap/size;
		System.out.println("각 비디오 진도율 평균: "+ avg);

		int runtimeAvg =  (int) Math.round(avg);
		System.out.println("각 비디오 진도율 평균 반올림: "+ runtimeAvg);

		if (runtimeAvg > 100) {
			runtimeAvg = 100;
		}


		System.out.println("my 데이터 확인: "+ my.toString());
		my.setRuntime(runtimeAvg);

		onlineClassService.updateRuntime(my);




		try {

			response.setContentType("application/json");
			// Get the printwriter object from response to write the required json object to the output stream
			PrintWriter out = response.getWriter();
			// Assuming your json object is **jsonObject**, perform the following, it will return your json object
			out.print("success");
			out.flush();
			out.close();


		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

	@RequestMapping("myOnlineDelete")
	public void myOnlineReview(@RequestParam("onlineOrderNo") int onlineOrderNo,
			HttpServletResponse response) {

		String msg = "삭제가 완료되었습니다.";

		onlineClassService.deleteClass(onlineOrderNo);

		PageUtil.alertAndRedirect("./myOnlineClass", msg, response);


	}

	@RequestMapping("myFileDown")
	public String myFileDown(@RequestParam("fileDir") String fileDir,
			@RequestParam("fileNameStr") String fileNameStr,
			@RequestParam("fileNameOrg") String fileNameOrg,
			ModelMap modelMap) {

		modelMap.put("fileNameStr", fileNameStr);
		modelMap.put("fileNameOrg", fileNameOrg);
	    modelMap.put("fileDir", fileDir);


		return "/lecture/onlec/myOnlineFileDown";


	}










}
