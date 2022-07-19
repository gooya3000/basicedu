package site.shoppingBasket;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import site.member.Member;
import site.util.UserSessionUtil;

@Controller
@RequestMapping("/shoppingBasket")
public class ShoppingBasketController {

	static Logger log = LoggerFactory.getLogger(ShoppingBasketController.class);

	@Resource(name="ShoppingBasketService")
	ShoppingBasketService shoppingBasketService;

	@RequestMapping("list")
	public String list(ShoppingBasket shoppingBasket, Model model) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}
		shoppingBasket.setId(user.getId());
		model.addAttribute("resultList", shoppingBasketService.findShoppingBasketList(shoppingBasket));
		return "/shoppingBasket/list";
	}

	@ResponseBody
	@RequestMapping("addToShoppingBasket")
	public String addToShoppingBasket(ShoppingBasket shoppingBasket) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}
		shoppingBasket.setId(user.getId());
		shoppingBasketService.saveShoppingBasket(shoppingBasket);
		return "success";
	}

	@ResponseBody
	@RequestMapping("delete")
	public String delete(ShoppingBasket shoppingBasket) {
		if (!UserSessionUtil.isLogin()) {
			return "redirect:/member/login";
		}
		for (int shoppingBasketNo : shoppingBasket.getShoppingBasketNoList()) {
			shoppingBasket.setShoppingBasketNo(shoppingBasketNo);
			shoppingBasketService.deleteShoppingBasket(shoppingBasket);
		}
		return "success";
	}

	@ResponseBody
	@RequestMapping("productStatusCheck")
	public String productStatusCheck() {
		String flag = "success";

		String shoppingBasketNoStr = (String) UserSessionUtil.getAttribute("userShoppingBasketNo");
		if (StringUtils.hasText(shoppingBasketNoStr)) {
			ShoppingBasket param = new ShoppingBasket();
			param.setShoppingBasketNoArr(shoppingBasketNoStr.split(","));

			List<ShoppingBasket> resultList = shoppingBasketService.findShoppingBasketList(param);
			for (ShoppingBasket result : resultList) {
				if (!"".equals(result.getProductStatus())) {
					flag = result.getProductStatus();
					break;
				}
			}
		}
		return flag;
	}
}
