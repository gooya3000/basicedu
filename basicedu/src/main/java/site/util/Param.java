package site.util;

public class Param extends Pagination {

	String keyword;
	String target;
	String id;
	int keyNo;
	String searchSe;

	String memberCategory;

	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getKeyNo() {
		return keyNo;
	}
	public void setKeyNo(int keyNo) {
		this.keyNo = keyNo;
	}
	public String getSearchSe() {
		return searchSe;
	}
	public void setSearchSe(String searchSe) {
		this.searchSe = searchSe;
	}
	public String getMemberCategory() {
		return memberCategory;
	}
	public void setMemberCategory(String memberCategory) {
		this.memberCategory = memberCategory;
	}
}
