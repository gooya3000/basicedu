package site.admin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

	static Logger log = LoggerFactory.getLogger(AdminController.class);

	@RequestMapping("login")
	public String login() {
		return "/admin/login";
	}
}