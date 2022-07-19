package site.lecture.online;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import site.util.Param;

@Service("OnlineClassService")
public class OnlineClassServiceImple implements OnlineClassService{

	@Autowired
	OnlineClassMapper mapper;

	@Override
	public void applyClass(OnlineClass dto) {
		// TODO Auto-generated method stub
		mapper.applyClass(dto);
	}

	@Override
	public List<OnlineClass> selectMyClass(Param param) {
		// TODO Auto-generated method stub
		return mapper.selectMyClass(param);
	}

	@Override
	public OnlineClass selectMyClassOne(OnlineClass my) {
		// TODO Auto-generated method stub
		return mapper.selectMyClassOne(my);
	}

	@Override
	public List<OnlineClass> selectOrder(int onlineLectureNo) {
		// TODO Auto-generated method stub
		return mapper.selectOrder(onlineLectureNo);
	}

	@Override
	public void updateRuntime(OnlineClass dto) {
		// TODO Auto-generated method stub
		mapper.updateRuntime(dto);
	}

	@Override
	public void updatePointBack(int onlineOrderNo) {
		// TODO Auto-generated method stub
		mapper.updatePointBack(onlineOrderNo);
	}


	@Override
	public void deleteClass(int onlineOrderNo) {
		// TODO Auto-generated method stub
		mapper.deleteClass(onlineOrderNo);
	}

	@Override
	public long countApplyClass(Param param) {
		// TODO Auto-generated method stub
		return mapper.countApplyClass(param);
	}

	@Override
	public int selectOrderNo(String paymentNo) {
		// TODO Auto-generated method stub
		return mapper.selectOrderNo(paymentNo);
	}

	@Override
	public void createMyProgress(OnlineClass videoDto) {
		// TODO Auto-generated method stub
		mapper.createMyProgress(videoDto);
	}

	@Override
	public OnlineClass selectNowVideo(OnlineClass my) {
		// TODO Auto-generated method stub
		return mapper.selectNowVideo(my);
	}

	@Override
	public void updateRuntimeEach(OnlineClass my) {
		// TODO Auto-generated method stub
		mapper.updateRuntimeEach(my);
	}

	@Override
	public List<OnlineClass> selectMyProgress(int onlineOrderNo) {
		// TODO Auto-generated method stub
		return mapper.selectMyProgress(onlineOrderNo);
	}

























}
