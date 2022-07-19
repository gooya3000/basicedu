package site.mypage.lecturer.offline;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class Offline {


	int offline_lecture_NO;
	String offline_lecture_name;
	String offline_lecture_introduce;
	String offline_lecture_img;
	String offline_lecture_address;
	int offline_lecture_min;
	int offline_lecture_max;
	String offline_lecture_applyperiodstart;
	String offline_lecture_schedule;
	Date offline_lecture_reg;
	String id;
	String offline_lecture_applyperiodend;

	int application_status;
	int application_no;


	public int getApplication_no() {
		return application_no;
	}

	public void setApplication_no(int application_no) {
		this.application_no = application_no;
	}

	public int getApplication_status() {
		return application_status;
	}

	public void setApplication_status(int application_status) {
		this.application_status = application_status;
	}

	MultipartFile offlineImg;

	String keyword;
	String searchCondition;

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getOffline_lecture_NO() {
		return offline_lecture_NO;
	}

	public void setOffline_lecture_NO(int offline_lecture_NO) {
		this.offline_lecture_NO = offline_lecture_NO;
	}

	public String getOffline_lecture_name() {
		return offline_lecture_name;
	}

	public void setOffline_lecture_name(String offline_lecture_name) {
		this.offline_lecture_name = offline_lecture_name;
	}

	public String getOffline_lecture_introduce() {
		return offline_lecture_introduce;
	}

	public void setOffline_lecture_introduce(String offline_lecture_introduce) {
		this.offline_lecture_introduce = offline_lecture_introduce;
	}

	public String getOffline_lecture_img() {
		return offline_lecture_img;
	}

	public void setOffline_lecture_img(String offline_lecture_img) {
		this.offline_lecture_img = offline_lecture_img;
	}

	public String getOffline_lecture_address() {
		return offline_lecture_address;
	}

	public void setOffline_lecture_address(String offline_lecture_address) {
		this.offline_lecture_address = offline_lecture_address;
	}

	public int getOffline_lecture_min() {
		return offline_lecture_min;
	}

	public void setOffline_lecture_min(int offline_lecture_min) {
		this.offline_lecture_min = offline_lecture_min;
	}

	public int getOffline_lecture_max() {
		return offline_lecture_max;
	}

	public void setOffline_lecture_max(int offline_lecture_max) {
		this.offline_lecture_max = offline_lecture_max;
	}

	public String getOffline_lecture_applyperiodstart() {
		return offline_lecture_applyperiodstart;
	}

	public void setOffline_lecture_applyperiodstart(String offline_lecture_applyperiodstart) {
		this.offline_lecture_applyperiodstart = offline_lecture_applyperiodstart;
	}

	public String getOffline_lecture_schedule() {
		return offline_lecture_schedule;
	}

	public void setOffline_lecture_schedule(String offline_lecture_schedule) {
		this.offline_lecture_schedule = offline_lecture_schedule;
	}

	public Date getOffline_lecture_reg() {
		return offline_lecture_reg;
	}

	public void setOffline_lecture_reg(Date offline_lecture_reg) {
		this.offline_lecture_reg = offline_lecture_reg;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOffline_lecture_applyperiodend() {
		return offline_lecture_applyperiodend;
	}

	public void setOffline_lecture_applyperiodend(String offline_lecture_applyperiodend) {
		this.offline_lecture_applyperiodend = offline_lecture_applyperiodend;
	}

	public MultipartFile getOfflineImg() {
		return offlineImg;
	}

	public void setOfflineImg(MultipartFile offlineImg) {
		this.offlineImg = offlineImg;
	}



}
