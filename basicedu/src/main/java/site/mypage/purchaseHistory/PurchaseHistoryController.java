package site.mypage.purchaseHistory;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import site.member.Member;
import site.order.Order;
import site.order.OrderService;
import site.util.Param;
import site.util.UserSessionUtil;

@Controller
@RequestMapping("/mypage/purchaseHistory")
public class PurchaseHistoryController {

	static Logger log = LoggerFactory.getLogger(PurchaseHistoryController.class);

	@Resource(name="OrderService")
	OrderService orderService;

	@RequestMapping("list")
	public String list(Param param, Model model) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}

		param.setId(user.getId());
		param.setTotalRecordCount(orderService.countPurchaseHistory(param));
		model.addAttribute("resultList", orderService.findPurchaseHistoryList(param));
		model.addAttribute("pagination", param);

		return "/mypage/purchaseHistory/list";
	}

	@RequestMapping("view")
	public String view(Order order, Model model) {
		if (!UserSessionUtil.isLogin()) {
			return "redirect:/member/login";
		}
		model.addAttribute("result", orderService.findPurchaseHistory(order));
		return "/mypage/purchaseHistory/view";
	}

	@ResponseBody
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String delete(Order order) {
		if (!UserSessionUtil.isLogin()) {
			return "redirect:/member/login";
		}
		for (String orderNo : order.getOrderNoArr()) {
			order.setOrderNo(Integer.parseInt(orderNo));
			orderService.deleteOrder(order);
		}
		return "success";
	}
}
