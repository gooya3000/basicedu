package site.mypage.lecturer.online;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import site.util.Param;

@Service("OnlecMgService")
public class OnlecMgServiceImple implements OnlecMgService {

	static Logger log = LoggerFactory.getLogger(OnlecMgServiceImple.class);

	@Autowired
	OnlecMgMapper onlecMgMapper;

	@Override
	public void registClass(OnlecMg dto) {
		// TODO Auto-generated method stub
		onlecMgMapper.registClass(dto);
	}

	@Override
	public void registVideo(OnlecMg dto) {
		// TODO Auto-generated method stub
		onlecMgMapper.registVideo(dto);
	}

	@Override
	public List<OnlecMg> selectLecturerAll(Param param) {
		// TODO Auto-generated method stub
		return onlecMgMapper.selectLecturerAll(param);
	}

	@Override
	public List<OnlecMg> selectAll(Param param) {
		// TODO Auto-generated method stub
		return onlecMgMapper.selectAll(param);
	}

	@Override
	public OnlecMg selectOne(int onlineLectureNo) {
		// TODO Auto-generated method stub
		return onlecMgMapper.selectOne(onlineLectureNo);
	}

	@Override
	public List<OnlecMg> selectOneVideo(int onlineLectureNo) {
		// TODO Auto-generated method stub
		return onlecMgMapper.selectOneVideo(onlineLectureNo);
	}

	@Override
	public int videoCount(int onlineLectureNo) {
		// TODO Auto-generated method stub
		return onlecMgMapper.videoCount(onlineLectureNo);
	}

	@Override
	public int updateClass(OnlecMg dto) {
		// TODO Auto-generated method stub
		return onlecMgMapper.updateClass(dto);
	}

	@Override
	public int updatVideo(OnlecMg dto) {
		// TODO Auto-generated method stub
		return onlecMgMapper.updateVideo(dto);
	}

	@Override
	public int deleteClass(int onlineLectureNo) {
		// TODO Auto-generated method stub
		return onlecMgMapper.deleteClass(onlineLectureNo);
	}

	@Override
	public int deleteVideo(int onlineLectureNo) {
		// TODO Auto-generated method stub
		return onlecMgMapper.deleteVideo(onlineLectureNo);
	}

	@Override
	public OnlecMg selectOneVideoNo(int videoNo) {
		// TODO Auto-generated method stub
		return onlecMgMapper.selectOneVideoNo(videoNo);
	}


	@Override
	public long countLClass(Param param) {
		// TODO Auto-generated method stub
		return onlecMgMapper.countLClass(param);
	}


	@Override
	public long searchSelectCount(Param param) {
		// TODO Auto-generated method stub
		return onlecMgMapper.searchSelectCount(param);
	}

	@Override
	public List<OnlecMg> searchSelect(Param param) {
		// TODO Auto-generated method stub
		return onlecMgMapper.searchSelect(param);
	}

















}
