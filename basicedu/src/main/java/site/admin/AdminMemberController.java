package site.admin;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import site.member.Member;
import site.member.MemberService;
import site.point.Point;
import site.point.PointService;
import site.util.AES256Util;
import site.util.Param;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {

	static Logger log = LoggerFactory.getLogger(AdminMemberController.class);

	@Resource(name="MemberService")
	MemberService memberService;

	@Resource(name="PointService")
	PointService pointService;

	public AES256Util AES256 = new AES256Util();

	@RequestMapping("memberListPop")
	public String memberListPop(Param param, Model model) {
		param.setMemberCategory("2");
		param.setTotalRecordCount((int) memberService.countMember(param));

		List<Member> resultList = memberService.findMemberList(param);
		for(Member result : resultList) {
			String phoneNumber = result.getPhoneNumber();
			if (StringUtils.hasText(phoneNumber)) {
				result.setPhoneNumber(AES256.decrypt(phoneNumber));
			}
		}
		model.addAttribute("resultList", resultList);
		model.addAttribute("pagination", param);
		return "/admin/member/memberListPop";
	}

	@RequestMapping(value="list", method = RequestMethod.GET)
	public String list(Model model, Param param) {

		param.setTotalRecordCount((int) memberService.countMember(param));

		List<Member> list = memberService.findMemberList(param);

		model.addAttribute("list", list);
		model.addAttribute("size", list.size());
		model.addAttribute("pagination", param);

		return "/admin/member/memberList";

	}

	@RequestMapping(value="list", method = RequestMethod.POST)
	public String listPost(AdminMemberCommand command, Model model, Param param) {

		String condition = command.getCondition();
		String keyword = command.getKeyword();
		param.setKeyword(keyword);
		param.setSearchSe("3");

		if (condition.equals("all")) {
			param.setMemberCategory("");
		}else if(condition.equals("lecturer")) {
			param.setMemberCategory("2");
		}else {
			param.setMemberCategory("1");
		}

		param.setTotalRecordCount((int) memberService.countMember(param));
		List<Member> list = memberService.findMemberList(param);

		model.addAttribute("list", list);
		model.addAttribute("size", list.size());
		model.addAttribute("pagination", param);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", command.getKeyword());

		return "/admin/member/memberList";

	}

	@RequestMapping(value="detail", method = RequestMethod.GET)
	public String detail(@RequestParam("id") String id, Model model) {

		Member member = memberService.findMemberOne(id);
		String address = "";
		String phoneNumber ="";
		String email ="";

		//가져온 개인정보 복호화
		if(member.getAddress() != null && member.getPhoneNumber() != null && member.getEmail() !=null) {
			address = AES256.decrypt(member.getAddress());
			phoneNumber = AES256.decrypt(member.getPhoneNumber());
			email = AES256.decrypt(member.getEmail());
		}

		member.setAddress(address);
		member.setPhoneNumber(phoneNumber);
		member.setEmail(email);

		model.addAttribute("member", member);

		//포인트 히스토리 리스트
		List<Point> point = pointService.pointHistory(id);

		model.addAttribute("point", point);
		model.addAttribute("size", point.size());

		return "/admin/member/memberDetail";

	}


}
