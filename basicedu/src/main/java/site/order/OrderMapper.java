package site.order;

import java.util.List;

import site.util.Param;

public interface OrderMapper {

	List<Order> findOrderList(Order order);

	int countPurchaseHistory(Param param);

	List<Order> findPurchaseHistoryList(Param param);

	Order findPurchaseHistory(Order order);

	long findTotalSales(Order order);

	void saveOrder(Order order);

	void modifyOrder(Order order);

	void deleteOrder(Order order);

	void savePayment(Payment payment);

	void modifyOrderStatusScheduler();
}
