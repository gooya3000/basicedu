package site.admin;

public class AdminMemberCommand {

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
	public AdminMemberCommand(String condition, String keyword) {
		super();
		this.condition = condition;
		this.keyword = keyword;
	}
	public AdminMemberCommand() {
		super();

	}




}
