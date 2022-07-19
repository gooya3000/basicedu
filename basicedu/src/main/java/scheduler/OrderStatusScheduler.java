package scheduler;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import site.order.OrderService;

@Component
public class OrderStatusScheduler {

	static Logger log = LoggerFactory.getLogger(OrderStatusScheduler.class);

	@Resource(name="OrderService")
	OrderService orderService;

	@Scheduled(cron = "0 0 12 * * *")
	public void orderStatusUpdate() {
		log.debug("orderStatusUpdate start");
		orderService.modifyOrderStatusScheduler();
		log.debug("orderStatusUpdate end");
	}
}
