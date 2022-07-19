package site.mypage.review;

import java.util.List;

public interface ReviewService {

	public int countReview(Review review);

	public List<Review> findReviewList(Review review);

	public Review findReview(Review review);

	public void saveReview(Review review);

	public void modifyReview(Review review);

	public void deleteReview(Review review);

}
