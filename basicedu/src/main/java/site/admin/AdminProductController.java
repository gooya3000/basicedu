package site.admin;

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

import site.mypage.product.Product;
import site.mypage.product.ProductService;
import site.order.OrderService;
import site.util.PageUtil;
import site.util.Param;
import site.util.ThumbnailUtil;

@Controller
@RequestMapping("/admin/product")
public class AdminProductController {

	static Logger log = LoggerFactory.getLogger(AdminProductController.class);

	@Resource(name="ProductService")
	ProductService productService;

	@Resource(name="OrderService")
	OrderService orderService;

	@Value("#{prop['file.path']}")
	private String uploadPath;

	@RequestMapping("list")
	public String list(Param param, Model model) {
		param.setTotalRecordCount(productService.countProduct(param));
		model.addAttribute("resultList", productService.findProductList(param));
		model.addAttribute("pagination", param);
		return "/admin/product/list";
	}

	@RequestMapping("write")
	public String write(@RequestParam(value="productNo", defaultValue="0") int productNo, Model model) {
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
		return "/admin/product/form";
	}

	@RequestMapping(value="writeAction", method=RequestMethod.POST)
	public void writeAction(Product product, MultipartHttpServletRequest request, HttpServletResponse response) {
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
		model.addAttribute("result", productService.findProduct(product));
		return "/admin/product/view";
	}

	@RequestMapping("delete")
	public void delete(Product product, HttpServletResponse response) {
		productService.deleteProduct(product);
		PageUtil.alertAndRedirect("./list", "삭제가 완료되었습니다.", response);
	}

	@RequestMapping("getSalesHistoryList")
	public String getSalesHistoryList(Param param, Model model) {
		param.setTotalRecordCount(orderService.countPurchaseHistory(param));
		model.addAttribute("salesHistoryList", orderService.findPurchaseHistoryList(param));
		model.addAttribute("pagination", param);
		return "/admin/product/salesHistoryList";
	}
}
