package site.order;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import site.util.Param;

@Service("OrderService")
public class OrderServiceImple implements OrderService {
	static Logger log = LoggerFactory.getLogger(OrderServiceImple.class);

	@Autowired
	OrderMapper orderMapper;

	@Override
	public List<Order> findOrderList(Order order) {
		return orderMapper.findOrderList(order);
	}

	@Override
	public int countPurchaseHistory(Param param) {
		return orderMapper.countPurchaseHistory(param);
	}

	@Override
	public List<Order> findPurchaseHistoryList(Param param) {
		return orderMapper.findPurchaseHistoryList(param);
	}

	@Override
	public Order findPurchaseHistory(Order order) {
		return orderMapper.findPurchaseHistory(order);
	}

	@Override
	public long findTotalSales(Order order) {
		return orderMapper.findTotalSales(order);
	}

	@Override
	public void saveOrder(Order order) {
		orderMapper.saveOrder(order);
	}

	@Override
	public void modifyOrder(Order order) {
		orderMapper.modifyOrder(order);
	}

	@Override
	public void deleteOrder(Order order) {
		orderMapper.deleteOrder(order);
	}

	@Override
	public void savePayment(Payment payment) {
		orderMapper.savePayment(payment);
	}

	@Override
	public void modifyOrderStatusScheduler() {
		orderMapper.modifyOrderStatusScheduler();
	}
}
