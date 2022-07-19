package site.mypage.lecturer.online;

import java.util.List;

import site.util.Param;

public interface OnlecMgMapper {

	void registClass(OnlecMg dto);
	void registVideo(OnlecMg dto);
	List<OnlecMg> selectLecturerAll(Param param);
	void selectLecturerOne();
	List<OnlecMg> selectOneVideo(int onlineLectureNo);
	List<OnlecMg> selectAll(Param param);
	OnlecMg selectOne(int onlineLectureNo);
	int videoCount(int onlineLectureNo);
	int updateClass(OnlecMg dto);
	int updateVideo(OnlecMg dto);
	int deleteClass(int onlineLectureNo);
	int deleteVideo(int onlineLectureNo);
	OnlecMg selectOneVideoNo(int videoNo);
	long countLClass(Param param);
	long searchSelectCount(Param param);
	List<OnlecMg> searchSelect(Param param);


}
