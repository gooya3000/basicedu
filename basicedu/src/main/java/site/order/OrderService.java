package site.order;

import java.util.List;

import site.util.Param;

public interface OrderService {

	public List<Order> findOrderList(Order order);

	public int countPurchaseHistory(Param param);

	public List<Order> findPurchaseHistoryList(Param param);

	public Order findPurchaseHistory(Order order);

	public long findTotalSales(Order order);

	public void saveOrder(Order order);

	public void modifyOrder(Order order);

	public void deleteOrder(Order order);

	public void savePayment(Payment payment);

	public void modifyOrderStatusScheduler();
}
