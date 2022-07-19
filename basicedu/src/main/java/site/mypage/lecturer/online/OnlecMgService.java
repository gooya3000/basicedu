package site.mypage.lecturer.online;

import java.util.List;

import site.util.Param;

public interface OnlecMgService {

	public void registClass(OnlecMg dto);
	public void registVideo(OnlecMg dto);
	public List<OnlecMg> selectLecturerAll(Param param);
	public List<OnlecMg> selectAll(Param param);
	public OnlecMg selectOne(int onlineLectureNo);
	public List<OnlecMg> selectOneVideo(int onlineLectureNo);
	public int videoCount(int onlineLectureNo);
	public int updateClass(OnlecMg dto);
	public int updatVideo(OnlecMg dto);
	public int deleteClass(int onlineLectureNo);
	public int deleteVideo(int onlineLectureNo);
	public OnlecMg selectOneVideoNo(int videoNo);
	public long countLClass(Param param);
	public long searchSelectCount(Param param);
	public List<OnlecMg> searchSelect(Param param);


}
