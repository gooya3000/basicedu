package site.mypage.review;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("ReviewService")
public class ReviewServiceImple implements ReviewService {

	static Logger log = LoggerFactory.getLogger(ReviewServiceImple.class);

	@Autowired
	ReviewMapper reviewMapper;

	@Override
	public int countReview(Review review) {
		return reviewMapper.countReview(review);
	}

	@Override
	public List<Review> findReviewList(Review review) {
		return reviewMapper.findReviewList(review);
	}

	@Override
	public Review findReview(Review review) {
		return reviewMapper.findReview(review);
	}

	@Override
	public void saveReview(Review review) {
		reviewMapper.saveReview(review);
	}

	@Override
	public void modifyReview(Review review) {
		reviewMapper.modifyReview(review);
	}

	@Override
	public void deleteReview(Review review) {
		reviewMapper.deleteReview(review);
	}

}
