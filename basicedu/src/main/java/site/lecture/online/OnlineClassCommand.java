package site.lecture.online;

public class OnlineClassCommand {

	/*사용할 포인트*/
	Integer point;
	Integer onlineLectureNo;

	/*리스트에서 강사명 또는 강의명으로 검색*/
	String condition;
	String keyword;


	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Integer getPoint() {
		return point;
	}
	public void setPoint(Integer usePoint) {
		this.point = usePoint;
	}
	public Integer getOnlineLectureNo() {
		return onlineLectureNo;
	}
	public void setOnlineLectureNo(Integer onlineLectureNo) {
		this.onlineLectureNo = onlineLectureNo;
	}



	public OnlineClassCommand(Integer point, Integer onlineLectureNo, String condition, String keyword) {
		super();
		this.point = point;
		this.onlineLectureNo = onlineLectureNo;
		this.condition = condition;
		this.keyword = keyword;
	}
	public OnlineClassCommand() {
		super();
	}




}
