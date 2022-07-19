package site.mypage.online;


public class MyOnlineClassCommand {

	/*리뷰*/
	Integer onlineLectureNo;
	String onlineReview;
	Integer onlineOrderNo;




	public Integer getOnlineOrderNo() {
		return onlineOrderNo;
	}
	public void setOnlineOrderNo(Integer onlineOrderNo) {
		this.onlineOrderNo = onlineOrderNo;
	}
	public Integer getOnlineLectureNo() {
		return onlineLectureNo;
	}
	public void setOnlineLectureNo(Integer onlineLectureNo) {
		this.onlineLectureNo = onlineLectureNo;
	}
	public String getOnlineReview() {
		return onlineReview;
	}
	public void setOnlineReview(String onlineReview) {
		this.onlineReview = onlineReview;
	}

	public MyOnlineClassCommand() {
		super();

	}
	public MyOnlineClassCommand(Integer onlineLectureNo, String onlineReview, Integer onlineOrderNo) {
		super();
		this.onlineLectureNo = onlineLectureNo;
		this.onlineReview = onlineReview;
		this.onlineOrderNo = onlineOrderNo;
	}
	@Override
	public String toString() {
		return "MyOnlineClassCommand [onlineLectureNo=" + onlineLectureNo + ", onlineReview=" + onlineReview
				+ ", onlineOrderNo=" + onlineOrderNo + "]";
	}











}
