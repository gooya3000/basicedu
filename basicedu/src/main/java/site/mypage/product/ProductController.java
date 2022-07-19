package site.mypage.product;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import site.member.Member;
import site.order.Order;
import site.order.OrderService;
import site.util.PageUtil;
import site.util.Param;
import site.util.ThumbnailUtil;
import site.util.UserSessionUtil;

@Controller
@RequestMapping("/mypage/product")
public class ProductController {

	static Logger log = LoggerFactory.getLogger(ProductController.class);

	@Resource(name="ProductService")
	ProductService productService;

	@Resource(name="OrderService")
	OrderService orderService;

	@Value("#{prop['file.path']}")
	private String uploadPath;

	@RequestMapping("list")
	public String list(Param param, Model model) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			return "redirect:/member/login";
		}
		param.setId(user.getId());
		param.setTotalRecordCount(productService.countProduct(param));
		model.addAttribute("resultList", productService.findProductList(param));
		model.addAttribute("pagination", param);
		return "/mypage/product/list";
	}

	@RequestMapping("write")
	public String write(@RequestParam(value="productNo", defaultValue="0") int productNo, Model model) {
		if (!UserSessionUtil.isLogin()) {
			return "redirect:/member/login";
		}

		if (productNo != 0) {
			Product param = new Product();
			param.setProductNo(productNo);

			Product result = productService.findProduct(param);
			String imgFileName = result.getImgFileName();
			if (!StringUtils.isEmpty(imgFileName)) {
				result.setImgFileName(imgFileName.substring(imgFileName.indexOf("_")+1));
			}
			String contentsFileName = result.getContentsFileName();
			if (!StringUtils.isEmpty(contentsFileName)) {
				result.setContentsFileName(contentsFileName.substring(contentsFileName.indexOf("_")+1));
			}
			model.addAttribute("result", result);
		}
		return "/mypage/product/form";
	}

	@RequestMapping(value="writeAction", method=RequestMethod.POST)
	public void writeAction(Product product, MultipartHttpServletRequest request, HttpServletResponse response) {
		Member user = UserSessionUtil.getUserSession();
		if (user == null) {
			PageUtil.redirect("/member/login", response);
			return;
		}
		product.setSellerId(user.getId());

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String now = sdf.format(new Date());
		String fileName = "";
		String msg = "등록이 완료되었습니다.";

		Iterator<String> it = request.getFileNames();
		while(it.hasNext()) {
			MultipartFile multipart = request.getFile(it.next().toString());
			if (!multipart.isEmpty()) {
				try {
					log.debug(multipart.getName() + " : " +  multipart.getOriginalFilename() + ", " + multipart.getContentType());

					fileName = now + "_" + multipart.getOriginalFilename();
					File file = new File(uploadPath + "/product/" + fileName);
					multipart.transferTo(file);

					if ("imgFile".equals(multipart.getName())) {
						product.setImgFileName(fileName);
						ThumbnailUtil.thumbnailImg(uploadPath + "/product/", fileName);
					} else {
						product.setContentsFileName(fileName);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		if (product.getProductNo() != 0) {
			productService.modifyProduct(product);
			msg = "수정이 완료되었습니다.";
		} else {
			productService.saveProduct(product);
		}
		PageUtil.alertAndRedirect("./list", msg, response);
	}

	@RequestMapping("view")
	public String view(Product product, Model model) {
		if (!UserSessionUtil.isLogin()) {
			return "redirect:/member/login";
		}
		model.addAttribute("result", productService.findProduct(product));

		Order order = new Order();
		order.setProductNo(product.getProductNo());
		model.addAttribute("totalSales", orderService.findTotalSales(order));
		return "/mypage/product/view";
	}

	@RequestMapping("delete")
	public void delete(int productNo, HttpServletResponse response) {
		if (!UserSessionUtil.isLogin()) {
			PageUtil.redirect("/member/login", response);
			return;
		}

		Product param = new Product();
		param.setProductNo(productNo);
		productService.deleteProduct(param);
		PageUtil.alertAndRedirect("./list", "삭제가 완료되었습니다.", response);
	}

	@RequestMapping("orderView")
	public String orderView(int orderNo, Model model) {
		if (!UserSessionUtil.isLogin()) {
			return "redirect:/member/login";
		}

		Order order = new Order();
		order.setOrderNo(orderNo);
		model.addAttribute("result", orderService.findPurchaseHistory(order));
		return "/mypage/product/orderView";
	}

	@RequestMapping("getSalesHistoryList")
	public String getSalesHistoryList(Param param, Model model) {
		param.setTotalRecordCount(orderService.countPurchaseHistory(param));
		model.addAttribute("salesHistoryList", orderService.findPurchaseHistoryList(param));
		model.addAttribute("pagination", param);
		return "/mypage/product/salesHistoryList";
	}
}
