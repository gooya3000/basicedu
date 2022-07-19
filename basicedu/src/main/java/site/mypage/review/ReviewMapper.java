package site.mypage.review;

import java.util.List;

public interface ReviewMapper {

	int countReview(Review review);

	List<Review> findReviewList(Review review);

	Review findReview(Review review);

	void saveReview(Review review);

	void modifyReview(Review review);

	void deleteReview(Review review);
}
