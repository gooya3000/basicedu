package site.mypage.review;

import java.util.Date;

public class Review {

	int reviewNo;
	int keyNo;
	String keySection;
	String id;
	String contents;
	Date registerDate;

	int productNo;

	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getKeyNo() {
		return keyNo;
	}
	public void setKeyNo(int keyNo) {
		this.keyNo = keyNo;
	}
	public String getKeySection() {
		return keySection;
	}
	public void setKeySection(String keySection) {
		this.keySection = keySection;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
}
