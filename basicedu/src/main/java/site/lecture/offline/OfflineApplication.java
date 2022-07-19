package site.lecture.offline;

import java.sql.Date;

public class OfflineApplication {

	int application_no;
	String application_name;
	String application_id;
	int application_number;
	String application_phone;
	Date application_regdate;
	String application_introduce;
	int offline_lecture_NO;
	int application_status;

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
	public String getApplication_name() {
		return application_name;
	}
	public void setApplication_name(String application_name) {
		this.application_name = application_name;
	}
	public String getApplication_id() {
		return application_id;
	}
	public void setApplication_id(String application_id) {
		this.application_id = application_id;
	}
	public int getApplication_number() {
		return application_number;
	}
	public void setApplication_number(int application_number) {
		this.application_number = application_number;
	}
	public String getApplication_phone() {
		return application_phone;
	}
	public void setApplication_phone(String application_phone) {
		this.application_phone = application_phone;
	}
	public Date getApplication_regdate() {
		return application_regdate;
	}
	public void setApplication_regdate(Date application_regdate) {
		this.application_regdate = application_regdate;
	}
	public String getApplication_introduce() {
		return application_introduce;
	}
	public void setApplication_introduce(String application_introduce) {
		this.application_introduce = application_introduce;
	}
	public int getOffline_lecture_NO() {
		return offline_lecture_NO;
	}
	public void setOffline_lecture_NO(int offline_lecture_NO) {
		this.offline_lecture_NO = offline_lecture_NO;
	}

}
