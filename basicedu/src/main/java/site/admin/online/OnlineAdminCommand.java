package site.admin.online;

public class OnlineAdminCommand {

	String condition;
	String keyword;
	Integer reviewNo[];
	Integer onlineLectureNo;

	public Integer[] getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(Integer[] reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}


	public Integer getOnlineLectureNo() {
		return onlineLectureNo;
	}

	public void setOnlineLectureNo(Integer onlineLectureNo) {
		this.onlineLectureNo = onlineLectureNo;
	}




	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}



	public OnlineAdminCommand(String condition, String keyword, Integer[] reviewNo, Integer onlineLectureNo) {
		super();
		this.condition = condition;
		this.keyword = keyword;
		this.reviewNo = reviewNo;
		this.onlineLectureNo = onlineLectureNo;
	}

	public OnlineAdminCommand() {
		super();

	}

}
