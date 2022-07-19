package site.mypage.lecturer.offline;

import java.util.List;

import site.lecture.offline.OfflineApplication;
import site.member.Member;
import site.mypage.review.Review;
import site.util.Param;

public interface OfflineMapper {

	void offlineJoinadd(Offline offline);

	List<Offline> offlineList(Param param);

	List<Offline> offlineList2(Offline offline);

	Offline offlineSelect(Offline offline);

	void offlineDelete(Offline offline);

	void offlineUpdate(Offline offline);

	void offlineUpdate1(Offline offline);

	String fileSearch(int offlineNo);

	List<Offline> offlineSelectAll(Param param);

	void offlineapplicationadd(OfflineApplication application);

	List<OfflineApplication> offapplicationList(Param param);

	OfflineApplication offaplicationSel(int application_no);

	void offaplicationApproval(OfflineApplication application);

	int offlecnumberSum(int offline_lecture_NO);

	int offlecnumberSumUser(int offline_lecture_NO);

	int offlecnumberSumReject(int offline_lecture_NO);

	String SearchlecturerId(String name);

	Member SearchlecturerName(String id);

	List<Offline> offlecSearch(Param param);

	List<Offline> offlineSearchName(Param param);

	int offapplicationCheck(OfflineApplication application);

	void myapplicationUpdate(OfflineApplication application);

	void myapplicationDelete(int application_no);

	void replyInsert(Review review);

	List<Review> replyList(Review review);

	List<Offline> offlineMylecture(Param param);

	String findImg(String id);

	long countClass();

	long countNameclass(Offline offline);

	long countCname(Offline offline);

	long countmyclass(String id);

	long myLectureCount(String id);

	long applicationListCount(int offline_lecture_NO);
}
