package site.lecture.online;

import java.util.Date;

public class OnlineClass {
	int onlineOrderNo;
	int onlineLectureNo;
	String id;
	Integer runtime;
	Date registerDate;
	Date latestAccessDate;

	String imgFile;
	String onlineLectureName;
	int price;

	int pointBack; // 0이면 환급 전, 1이면 환급 후

	String paymentNo;

	int videoNo;

	public int getOnlineLectureNo() {
		return onlineLectureNo;
	}
	public void setOnlineLectureNo(int onlineLectureNo) {
		this.onlineLectureNo = onlineLectureNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Integer getRuntime() {
		return runtime;
	}
	public void setRuntime(Integer runtime) {
		this.runtime = runtime;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public Date getLatestAccessDate() {
		return latestAccessDate;
	}
	public void setLatestAccessDate(Date latestAccessDate) {
		this.latestAccessDate = latestAccessDate;
	}


	public String getImgFile() {
		return imgFile;
	}
	public void setImgFile(String imgFile) {
		this.imgFile = imgFile;
	}
	public String getOnlineLectureName() {
		return onlineLectureName;
	}
	public void setOnlineLectureName(String onlineLectureName) {
		this.onlineLectureName = onlineLectureName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}



	public int getPointBack() {
		return pointBack;
	}
	public void setPointBack(int pointBack) {
		this.pointBack = pointBack;
	}



	public int getOnlineOrderNo() {
		return onlineOrderNo;
	}
	public void setOnlineOrderNo(int onlineOrderNo) {
		this.onlineOrderNo = onlineOrderNo;
	}
	public String getPaymentNo() {
		return paymentNo;
	}
	public void setPaymentNo(String paymentNo) {
		this.paymentNo = paymentNo;
	}
	public int getVideoNo() {
		return videoNo;
	}
	public void setVideoNo(int videoNo) {
		this.videoNo = videoNo;
	}
	@Override
	public String toString() {
		return "OnlineClass [onlineOrderNo=" + onlineOrderNo + ", onlineLectureNo=" + onlineLectureNo + ", id=" + id
				+ ", runtime=" + runtime + ", registerDate=" + registerDate + ", latestAccessDate=" + latestAccessDate
				+ ", imgFile=" + imgFile + ", onlineLectureName=" + onlineLectureName + ", price=" + price
				+ ", pointBack=" + pointBack + ", paymentNo=" + paymentNo + ", videoNo=" + videoNo + "]";
	}











}
