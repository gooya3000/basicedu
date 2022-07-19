package site.point;

import java.util.List;

public interface PointService {

	public void insertHistory(Point point);

	public List<Point> pointHistory(String id);



}
