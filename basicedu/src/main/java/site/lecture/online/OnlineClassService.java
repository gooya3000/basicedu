package site.lecture.online;

import java.util.List;

import site.util.Param;

public interface OnlineClassService {

	void applyClass(OnlineClass dto);

	List<OnlineClass> selectMyClass(Param param);

	OnlineClass selectMyClassOne(OnlineClass my);

	List<OnlineClass> selectOrder(int onlineLectureNo);

	void updateRuntime(OnlineClass dto);

	void updatePointBack(int onlineOrderNo);

	void deleteClass(int onlineOrderNo);

	long countApplyClass(Param param);

	int selectOrderNo(String paymentNo);

	void createMyProgress(OnlineClass videoDto);

	OnlineClass selectNowVideo(OnlineClass my);

	void updateRuntimeEach(OnlineClass my);

	List<OnlineClass> selectMyProgress(int onlineOrderNo);



}
