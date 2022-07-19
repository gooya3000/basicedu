package site.mypage.review;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import site.member.Member;
import site.util.UserSessionUtil;

@Controller
@RequestMapping("/mypage/review")
public class ReviewController {

	static Logger log = LoggerFactory.getLogger(ReviewController.class);

	@Resource(name="ReviewService")
	ReviewService reviewService;

	@ResponseBody
	@RequestMapping(value="writeAction", method=RequestMethod.POST)
	public String writeAction(Review review) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}
		review.setId(user.getId());

		if (review.getReviewNo() != 0) {
			reviewService.modifyReview(review);
		} else {
			reviewService.saveReview(review);
		}
		return "success";
	}

	@ResponseBody
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String delete(Review review) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}
		review.setId(user.getId());
		reviewService.deleteReview(review);
		return "success";
	}

	@ResponseBody
	@RequestMapping(value = "update", method=RequestMethod.POST)
	public String update(Review review) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}
		review.setId(user.getId());
		reviewService.modifyReview(review);
		return "success";
	}
}
