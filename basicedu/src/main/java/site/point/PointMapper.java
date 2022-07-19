package site.point;

import java.util.List;

public interface PointMapper {

	void insertHistory(Point point);

	List<Point> pointHistory(String id);



}
