package site.store;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import site.mypage.product.Product;
import site.mypage.product.ProductService;
import site.mypage.review.Review;
import site.mypage.review.ReviewService;
import site.util.Param;

@Controller
@RequestMapping("/store")
public class StoreController {

	static Logger log = LoggerFactory.getLogger(StoreController.class);

	@Resource(name="ProductService")
	ProductService productService;

	@Resource(name="ReviewService")
	ReviewService reviewService;

	@RequestMapping("list")
	public String list(Param param, Model model) {
		param.setTarget("store");
		param.setRecordCountPerPage(12);
		param.setTotalRecordCount(productService.countProduct(param));
		model.addAttribute("resultList", productService.findProductList(param));
		model.addAttribute("pagination", param);
		return "/store/list";
	}

	@RequestMapping("view")
	public String view(Product product, Model model) {
		Product result = productService.findProduct(product);
		model.addAttribute("result", result);

		Param param = new Param();
		param.setKeyNo(product.getProductNo());
		param.setId(result.getSellerId());
		param.setTarget("store");
		param.setRecordCountPerPage(4);
		model.addAttribute("resultList", productService.findProductList(param));

		Review review = new Review();
		review.setProductNo(product.getProductNo());
		review.setKeySection("P");
		model.addAttribute("reviewList", reviewService.findReviewList(review));

		return "/store/view";
	}
}
