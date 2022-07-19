package site.point;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("PointService")
public class PointServiceImple implements PointService{

	@Autowired
	PointMapper pointMapper;

	@Override
	public void insertHistory(Point point) {
		// TODO Auto-generated method stub
		pointMapper.insertHistory(point);
	}

	@Override
	public List<Point> pointHistory(String id) {
		// TODO Auto-generated method stub
		return pointMapper.pointHistory(id);
	}





}
