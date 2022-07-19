package site.mypage.lecturer.online;

import java.util.Date;

public class OnlecMg {

	/*강의정보*/
	int onlineLectureNo;
	String lecturerId;
	String onlineLectureName;
	String onlineLectureInfo;
	String imgFile;
	int price;
	String libraryFileOrg;
	String libraryFileStr;
	Date registerDate;

	/*영상정보*/
	int videoNo;
	int chapterNo;

	int videoQty;
	String videoName;
	String videoInfo;
	String videoFile;
	String videoFileOrg;

	/*강의정보*/
	String name;
	String lecturerImg;
	String lecturerInfo;



	public int getOnlineLectureNo() {
		return onlineLectureNo;
	}
	public void setOnlineLectureNo(int onlineLectureNo) {
		this.onlineLectureNo = onlineLectureNo;
	}
	public String getLecturerId() {
		return lecturerId;
	}
	public void setLecturerId(String lecturerId) {
		this.lecturerId = lecturerId;
	}

	public String getOnlineLectureName() {
		return onlineLectureName;
	}
	public void setOnlineLectureName(String onlineLectureName) {
		this.onlineLectureName = onlineLectureName;
	}
	public String getOnlineLectureInfo() {
		return onlineLectureInfo;
	}
	public void setOnlineLectureInfo(String onlineLectureInfo) {
		this.onlineLectureInfo = onlineLectureInfo;
	}
	public int getVideoNo() {
		return videoNo;
	}
	public void setVideoNo(int videoNo) {
		this.videoNo = videoNo;
	}
	public int getChapterNo() {
		return chapterNo;
	}
	public void setChapterNo(int chapterNo) {
		this.chapterNo = chapterNo;
	}

	public int getVideoQty() {
		return videoQty;
	}
	public void setVideoQty(int videoQty) {
		this.videoQty = videoQty;
	}

	public String getVideoName() {
		return videoName;
	}
	public void setVideoName(String videoName) {
		this.videoName = videoName;
	}
	public String getVideoInfo() {
		return videoInfo;
	}
	public void setVideoInfo(String videoInfo) {
		this.videoInfo = videoInfo;
	}
	public String getVideoFile() {
		return videoFile;
	}
	public void setVideoFile(String videoFile) {
		this.videoFile = videoFile;
	}
	public String getImgFile() {
		return imgFile;
	}
	public void setImgFile(String imgFile) {
		this.imgFile = imgFile;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getLibraryFileOrg() {
		return libraryFileOrg;
	}
	public void setLibraryFileOrg(String libraryFileOrg) {
		this.libraryFileOrg = libraryFileOrg;
	}
	public String getLibraryFileStr() {
		return libraryFileStr;
	}
	public void setLibraryFileStr(String libraryFileStr) {
		this.libraryFileStr = libraryFileStr;
	}



	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}






	public String getVideoFileOrg() {
		return videoFileOrg;
	}
	public void setVideoFileOrg(String videoFileOrg) {
		this.videoFileOrg = videoFileOrg;
	}
	public String getLecturerImg() {
		return lecturerImg;
	}
	public void setLecturerImg(String lecturerImg) {
		this.lecturerImg = lecturerImg;
	}
	public String getLecturerInfo() {
		return lecturerInfo;
	}
	public void setLecturerInfo(String lecturerInfo) {
		this.lecturerInfo = lecturerInfo;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	@Override
	public String toString() {
		return "OnlecMg [onlineLectureNo=" + onlineLectureNo + ", lecturerId=" + lecturerId + ", onlineLectureName="
				+ onlineLectureName + ", onlineLectureInfo=" + onlineLectureInfo + ", imgFile=" + imgFile + ", price="
				+ price + ", libraryFileOrg=" + libraryFileOrg + ", libraryFileStr=" + libraryFileStr
				+ ", registerDate=" + registerDate + ", videoNo=" + videoNo + ", chapterNo=" + chapterNo + ", videoQty="
				+ videoQty + ", videoName=" + videoName + ", videoInfo=" + videoInfo + ", videoFile=" + videoFile
				+ ", videoFileOrg=" + videoFileOrg + ", name=" + name + ", lecturerImg=" + lecturerImg
				+ ", lecturerInfo=" + lecturerInfo + "]";
	}















}
