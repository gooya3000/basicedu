package site.util;

public class Pagination {

	int pageIndex = 1;
	int recordCountPerPage = 10;
	int pageSize = 10;
	int totalRecordCount;

	int totalPageCount;
	int firstPageNo;
	int lastPageNo;
	int firstRecordIndex;
	int lastRecordIndex;

	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		if (pageIndex < 1) {
			pageIndex = 1;
		}
		this.pageIndex = pageIndex;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalRecordCount() {
		return totalRecordCount;
	}
	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;

		this.totalPageCount = ((totalRecordCount - 1) / recordCountPerPage) + 1;
		this.firstPageNo = ((pageIndex - 1) / pageSize) * pageSize + 1;
		this.lastPageNo = firstPageNo + pageSize - 1;
		if (lastPageNo > totalPageCount) {
			this.lastPageNo = totalPageCount;
		}
		this.firstRecordIndex = (pageIndex - 1) * recordCountPerPage;
		this.lastRecordIndex = pageIndex * recordCountPerPage;
	}
	public int getTotalPageCount() {
		return totalPageCount;
	}
	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}
	public int getFirstPageNo() {
		return firstPageNo;
	}
	public void setFirstPageNo(int firstPageNo) {
		this.firstPageNo = firstPageNo;
	}
	public int getLastPageNo() {
		return lastPageNo;
	}
	public void setLastPageNo(int lastPageNo) {
		this.lastPageNo = lastPageNo;
	}
	public int getFirstRecordIndex() {
		return firstRecordIndex;
	}
	public void setFirstRecordIndex(int firstRecordIndex) {
		this.firstRecordIndex = firstRecordIndex;
	}
	public int getLastRecordIndex() {
		return lastRecordIndex;
	}
	public void setLastRecordIndex(int lastRecordIndex) {
		this.lastRecordIndex = lastRecordIndex;
	}
}
