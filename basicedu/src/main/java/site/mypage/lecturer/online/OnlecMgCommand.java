package site.mypage.lecturer.online;


import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;


public class OnlecMgCommand {

	/*강사정보*/
	String lecturerId;

	/*강의정보*/
	int onlineLectureNo;
	String onlineLectureName;
	String onlineLectureInfo;
	MultipartFile lectureFiles[];
	int price;
	String name;

	/*영상정보*/
	int videoQty;
	String videoName[];
	String videoInfo[];
	MultipartFile videoFile[];


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

	public int getVideoQty() {
		return videoQty;
	}
	public void setVideoQty(int videoQty) {
		this.videoQty = videoQty;
	}
	public String[] getVideoName() {
		return videoName;
	}
	public void setVideoName(String[] videoName) {
		this.videoName = videoName;
	}
	public String[] getVideoInfo() {
		return videoInfo;
	}
	public void setVideoInfo(String[] videoInfo) {
		this.videoInfo = videoInfo;
	}

	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}

	public MultipartFile[] getVideoFile() {
		return videoFile;
	}
	public void setVideoFile(MultipartFile[] videoFile) {
		this.videoFile = videoFile;
	}


	public MultipartFile[] getLectureFiles() {
		return lectureFiles;
	}
	public void setLectureFiles(MultipartFile[] lectureFiles) {
		this.lectureFiles = lectureFiles;
	}
	public OnlecMgCommand() {

	}
	public int getOnlineLectureNo() {
		return onlineLectureNo;
	}
	public void setOnlineLectureNo(int onlineLectureNo) {
		this.onlineLectureNo = onlineLectureNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getLecturerId() {
		return lecturerId;
	}
	public void setLecturerId(String lecturerId) {
		this.lecturerId = lecturerId;
	}
	public OnlecMgCommand(String lecturerId, int onlineLectureNo, String onlineLectureName, String onlineLectureInfo,
			MultipartFile[] lectureFiles, int price, String name, int videoQty, String[] videoName, String[] videoInfo,
			MultipartFile[] videoFile) {
		super();
		this.lecturerId = lecturerId;
		this.onlineLectureNo = onlineLectureNo;
		this.onlineLectureName = onlineLectureName;
		this.onlineLectureInfo = onlineLectureInfo;
		this.lectureFiles = lectureFiles;
		this.price = price;
		this.name = name;
		this.videoQty = videoQty;
		this.videoName = videoName;
		this.videoInfo = videoInfo;
		this.videoFile = videoFile;
	}












}
