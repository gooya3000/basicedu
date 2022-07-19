package site.mypage.lecturer.offline;

import java.util.List;

import site.lecture.offline.OfflineApplication;
import site.member.Member;
import site.mypage.review.Review;
import site.util.Param;

public interface OfflineService{

	public void offlineJoinadd(Offline offline);

	public List<Offline> offlineList(Param param);

	List<Offline> offlineList2(Offline offline);

	public Offline offlineSelect(Offline offline);

	public void offlineDelete(Offline offline);

	public void offlineUpdate(Offline offline);

	public void offlineUpdate1(Offline offline);

	public String fileSearch(int offlineNo);

	public List<Offline> offlineSelectAll(Param param);

	public void offlineapplicationadd(OfflineApplication application);

	public List<OfflineApplication> offapplicationList(Param param);

	public OfflineApplication offaplicationSel(int application_no);

	public void offaplicationApproval(OfflineApplication application);

	public int offlecnumberSum(int offline_lecture_NO);

	public int offlecnumberSumUser(int offline_lecture_NO);

	public int offlecnumberSumReject(int offline_lecture_NO);

	public String SearchlecturerId(String name);

	public Member SearchlecturerName(String id);

	public List<Offline> offlecSearch(Param param);

	public List<Offline> offlineSearchName(Param param);

	public int offapplicationCheck(OfflineApplication application);

	public void myapplicationUpdate(OfflineApplication application);

	public void myapplicationDelete(int application_no);

	public void replyInsert(Review review);

	public List<Review> replyList(Review review);

	public List<Offline> offlineMylecture(Param param);

	public String findImg(String id);

	public long countClass();

	public long countNameclass(Offline offline);

	public long countCname(Offline offline);

	public long countmyclass(String id);

	public long myLectureCount(String id);

	public long applicationListCount(int offline_lecture_NO);

}