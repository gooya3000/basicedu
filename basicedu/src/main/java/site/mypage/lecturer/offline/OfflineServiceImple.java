package site.mypage.lecturer.offline;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import site.lecture.offline.OfflineApplication;
import site.member.Member;
import site.mypage.review.Review;
import site.util.Param;


@Service("OfflineService")
public class OfflineServiceImple implements OfflineService {

	static Logger log = LoggerFactory.getLogger(OfflineServiceImple.class);


	@Autowired
	OfflineMapper offlineMapper;

	@Override
	public void offlineJoinadd(Offline offline) {
		log.debug("offlineService");
		offlineMapper.offlineJoinadd(offline);
	}

	@Override
	public List<Offline> offlineList(Param param) {
		return offlineMapper.offlineList(param);
	}

	@Override
	public List<Offline> offlineList2(Offline offline) {
		return offlineMapper.offlineList2(offline);
	}

	@Override
	public Offline offlineSelect(Offline offline) {
		return offlineMapper.offlineSelect(offline);
	}

	@Override
	public void offlineDelete(Offline offline) {
		offlineMapper.offlineDelete(offline);
	}

	@Override
	public void offlineUpdate(Offline offline) {
		offlineMapper.offlineUpdate(offline);

	}

	@Override
	public void offlineUpdate1(Offline offline) {
		offlineMapper.offlineUpdate1(offline);

	}

	@Override
	public String fileSearch(int offlineNo) {
		return offlineMapper.fileSearch(offlineNo);

	}

	@Override
	public List<Offline> offlineSelectAll(Param param) {
		return offlineMapper.offlineSelectAll(param);
	}

	@Override
	public void offlineapplicationadd(OfflineApplication application) {
		offlineMapper.offlineapplicationadd(application);

	}

	@Override
	public List<OfflineApplication> offapplicationList(Param param) {
		return offlineMapper.offapplicationList(param);
	}

	@Override
	public OfflineApplication offaplicationSel(int application_no) {
		return offlineMapper.offaplicationSel(application_no);
	}

	@Override
	public void offaplicationApproval(OfflineApplication application) {
		offlineMapper.offaplicationApproval(application);

	}

	@Override
	public int offlecnumberSum(int offline_lecture_NO) {
		return offlineMapper.offlecnumberSum(offline_lecture_NO);
	}

	@Override
	public int offlecnumberSumUser(int offline_lecture_NO) {
		return offlineMapper.offlecnumberSumUser(offline_lecture_NO);
	}

	@Override
	public int offlecnumberSumReject(int offline_lecture_NO) {
		return offlineMapper.offlecnumberSumReject(offline_lecture_NO);
	}


	@Override
	public String SearchlecturerId(String name) {
		return offlineMapper.SearchlecturerId(name);
	}

	@Override
	public Member SearchlecturerName(String id) {
		return offlineMapper.SearchlecturerName(id);
	}

	@Override
	public List<Offline> offlecSearch(Param param) {
		return offlineMapper.offlecSearch(param);
	}

	@Override
	public List<Offline> offlineSearchName(Param param) {
		return offlineMapper.offlineSearchName(param);
	}

	@Override
	public int offapplicationCheck(OfflineApplication application) {
		return offlineMapper.offapplicationCheck(application);
	}

	@Override
	public void myapplicationUpdate(OfflineApplication application) {
		offlineMapper.myapplicationUpdate(application);

	}

	@Override
	public void myapplicationDelete(int application_no) {
		offlineMapper.myapplicationDelete(application_no);
	}

	@Override
	public void replyInsert(Review review) {
		offlineMapper.replyInsert(review);

	}

	@Override
	public List<Review> replyList(Review review) {
		return offlineMapper.replyList(review);
	}

	@Override
	public List<Offline> offlineMylecture(Param param) {
		return offlineMapper.offlineMylecture(param);
	}

	@Override
	public String findImg(String id) {
		return offlineMapper.findImg(id);
	}

	@Override
	public long countClass() {
		return offlineMapper.countClass();
	}

	@Override
	public long countNameclass(Offline offline) {
		return offlineMapper.countNameclass(offline);
	}

	@Override
	public long countCname(Offline offline) {
		return offlineMapper.countCname(offline);
	}

	@Override
	public long countmyclass(String id) {
		return offlineMapper.countmyclass(id);
	}

	@Override
	public long myLectureCount(String id) {
		return offlineMapper.myLectureCount(id);
	}

	@Override
	public long applicationListCount(int offline_lecture_NO) {
		return offlineMapper.applicationListCount(offline_lecture_NO);
	}







}