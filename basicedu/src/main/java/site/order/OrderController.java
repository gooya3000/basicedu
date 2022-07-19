package site.order;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import site.member.Member;
import site.member.MemberService;
import site.mypage.product.Product;
import site.mypage.product.ProductService;
import site.point.Point;
import site.point.PointService;
import site.shoppingBasket.ShoppingBasket;
import site.shoppingBasket.ShoppingBasketService;
import site.util.AES256Util;
import site.util.PageUtil;
import site.util.UserSessionUtil;

@Controller
@RequestMapping("/order")
public class OrderController {

	static Logger log = LoggerFactory.getLogger(OrderController.class);

	@Resource(name="ProductService")
	ProductService productService;

	@Resource(name="ShoppingBasketService")
	ShoppingBasketService shoppingBasketService;

	@Resource(name="OrderService")
	OrderService orderService;

	@Resource(name="MemberService")
	MemberService memberService;

	@Resource(name="PointService")
	PointService pointService;

	public AES256Util AES256 = new AES256Util();

	@RequestMapping(value="", method=RequestMethod.POST)
	public String order(ShoppingBasket shoppingBasket, ModelMap model, HttpSession session) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}

		Member userInfo = memberService.findMember(user);
		if (StringUtils.hasText(user.getPhoneNumber())) {
			userInfo.setPhoneNumber(AES256.decrypt(user.getPhoneNumber()));
		}
		if (StringUtils.hasText(user.getAddress())) {
			userInfo.setAddress(AES256.decrypt(user.getAddress()));
		}
		if (StringUtils.hasText(user.getEmail())) {
			userInfo.setEmail(AES256.decrypt(user.getEmail()));
		}
		model.addAttribute("user", userInfo);

		String orderNoStr = "";
		Order param = new Order();
		param.setId(user.getId());

		List<Integer> shoppingBasketNoList = shoppingBasket.getShoppingBasketNoList();
		if (shoppingBasketNoList == null) {
			param.setProductNo(shoppingBasket.getProductNo());
			param.setQuantity(shoppingBasket.getQuantity());
			param.setProductPrice(shoppingBasket.getProductPrice());
			orderService.saveOrder(param);
			orderNoStr = String.valueOf(param.getOrderNo());
		} else {
			String shoppingBasketStr = "";
			for (int shoppingBasketNo : shoppingBasketNoList) {
				shoppingBasketStr += shoppingBasketNo + ",";
			}
			session.setAttribute("userShoppingBasketNo", shoppingBasketStr);
			shoppingBasket.setShoppingBasketNoArr(shoppingBasketStr.split(","));
			for (ShoppingBasket result : shoppingBasketService.findShoppingBasketList(shoppingBasket)) {
				param.setProductNo(result.getProductNo());
				param.setQuantity(result.getQuantity());
				param.setProductPrice(result.getProductPrice());
				orderService.saveOrder(param);
				orderNoStr += param.getOrderNo() + ",";
			}
		}
		param = new Order();
		param.setOrderNoArr(orderNoStr.split(","));
		model.addAttribute("resultList", orderService.findOrderList(param));
		model.addAttribute("orderNoStr", orderNoStr);
		return "/order/orderForm";
	}

	@RequestMapping(value="payment", method=RequestMethod.POST)
	public void orderAction(String orderNoStr, Payment payment, HttpServletResponse response, HttpSession session) {
		if (!UserSessionUtil.isLogin()) {
			PageUtil.redirect("/member/login", response);
			return;
		}
		Order param = new Order();
		param.setPaymentNo(payment.getPaymentNo());
		param.setOrderStatus("1");
		for (String orderNo : orderNoStr.split(",")) {
			param.setOrderNo(Integer.parseInt(orderNo));
			orderService.modifyOrder(param);
		}
		orderService.savePayment(payment);

		param = new Order();
		param.setOrderNoArr(orderNoStr.split(","));
		List<Order> resultList = orderService.findOrderList(param);
		if (resultList != null) {
			for (Order result : resultList) {
				Product product = new Product();
				product.setQuantity(result.getQuantity());
				product.setProductNo(result.getProductNo());
				productService.modifyProductQuantityByOrder(product);
			}
		}

		if (payment.getPoint() != 0) {
			Member user = UserSessionUtil.getUserSession();
			int userPoint = memberService.nowPoint(user.getId());
			int usePoint = payment.getPoint();
			user.setPoint(userPoint - usePoint);
			memberService.updatePoint(user);

			Point point = new Point();
			point.setPoint(-usePoint);
			point.setContents("스토어 상품 구매");
			point.setId(user.getId());
			pointService.insertHistory(point);
		}

		String shoppingBasketNoStr = (String) UserSessionUtil.getAttribute("userShoppingBasketNo");
		if (shoppingBasketNoStr != null) {
			log.debug("shoppingBasketNoStr : " + shoppingBasketNoStr);
			for (String shoppingBasketNo : shoppingBasketNoStr.split(",")) {
				ShoppingBasket shoppingBasket = new ShoppingBasket();
				shoppingBasket.setShoppingBasketNo(Integer.parseInt(shoppingBasketNo));
				shoppingBasketService.deleteShoppingBasket(shoppingBasket);

				session.removeAttribute("userShoppingBasketNo");
			}
		}
		PageUtil.alertAndRedirect("/mypage/purchaseHistory/list", "결제가 완료되었습니다.", response);
	}

	@ResponseBody
	@RequestMapping("modifyOrderStatus")
	public String modifyOrderStatus(int orderNo, String orderStatus) {
		if (!UserSessionUtil.isLogin()) {
			return "redirect:/member/login";
		}
		Order param = new Order();
		param.setOrderNo(orderNo);
		param.setOrderStatus(orderStatus);
		orderService.modifyOrder(param);
		return "success";
	}
}
