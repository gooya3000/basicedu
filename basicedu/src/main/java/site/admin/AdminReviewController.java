package site.admin;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import site.mypage.review.Review;
import site.mypage.review.ReviewService;

@Controller
@RequestMapping("/admin/review")
public class AdminReviewController {

	static Logger log = LoggerFactory.getLogger(AdminReviewController.class);

	@Resource(name="ReviewService")
	ReviewService reviewService;

	@ResponseBody
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String delete(Review review) {
		review.setId("admin");
		reviewService.deleteReview(review);
		return "success";
	}
}
