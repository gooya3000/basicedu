package site.mypage.member;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import site.member.Member;
import site.member.MemberService;
import site.store.StoreController;
import site.util.AES256Util;
import site.util.PageUtil;
import site.util.ThumbnailUtil;
import site.util.UserSessionUtil;

@Controller
@RequestMapping("/mypage/member")
public class MyMemberController {

	public AES256Util AES256 = new AES256Util();

	public BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	static Logger log = LoggerFactory.getLogger(StoreController.class);

	@Resource(name="MemberService")
	MemberService memberService;

	@Value("#{prop['file.path']}")
	private String uploadPath;

	@RequestMapping("/memberCertify")
	public String memberCertify(HttpSession session,Model model) {
		if (!UserSessionUtil.isLogin()) {
			return "redirect:/member/login";
		}
		Member member=(Member) session.getAttribute("userSession");
		String id = member.getId();


		model.addAttribute("id",id);

		return"/mypage/member/memberCertify";
	}

	@RequestMapping(value="/memberUpdate")
	public String memberUpdate(HttpSession session,Model model) {
		if (!UserSessionUtil.isLogin()) {
			return "redirect:/member/login";
		}

		Member member=(Member) session.getAttribute("userSession");

		log.debug(member.getId());

		member = memberService.memberInfo(member.getId());

		String address =member.getAddress();
		String phoneNumber=member.getPhoneNumber();
		String email=member.getEmail();
		String name = member.getName();

		log.debug(email + "         " + phoneNumber + "        " + email);

		address = AES256.decrypt(address);
		phoneNumber = AES256.decrypt(phoneNumber);
		email = AES256.decrypt(email);

		member.setAddress(address);
		member.setPhoneNumber(phoneNumber);
		member.setEmail(email);
		member.setName(name);

		model.addAttribute("member",member);


		return"/mypage/member/memberUpdate";
	}

	@ResponseBody
	@RequestMapping(value = "passwordCheck")
	public String passwordCheck(Member member, HttpSession session) {
		String result = "success";
		Member member1=(Member) session.getAttribute("userSession");
		member.setId(member1.getId());



		if(!passwordEncoder.matches(member.getPassword(), memberService.passwordCheck(member))) {
			result= "fail";
		};

		return result;

	}

	@RequestMapping(value="updateAction", method=RequestMethod.POST)
	public void updateAction(Member member, @RequestParam(value = "img") MultipartFile multipart, HttpServletResponse response,HttpSession session) {
		Member member1=(Member) session.getAttribute("userSession");
		String id = member1.getId();

		log.debug(id);
		member.setId(id);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String time = sdf.format(new Date());
		String fileName = "";

		String preFile = memberService.findLecturerImg(id);

		log.debug("파일 찾기" + preFile);

		File main = new File(uploadPath + "/lecturer/" + preFile);
		File thumb = new File(uploadPath + "/lecturer/thumb/" + preFile);

		if (main.exists()) {
			main.delete();
			thumb.delete();

		}

		log.debug(member.getLecturerImg() + "  소개    " + member.getLecturerInfo());

		log.debug(multipart.getName() + " : " + multipart.getOriginalFilename() + ", " + multipart.getContentType());

		try {
			log.debug(
					multipart.getName() + " : " + multipart.getOriginalFilename() + ", " + multipart.getContentType());

			fileName = time + "_" + multipart.getOriginalFilename();
			File file = new File(uploadPath + "/lecturer/" + fileName);
			multipart.transferTo(file);
			if ("img".equals(multipart.getName())) {
				member.setLecturerImg(fileName);
				ThumbnailUtil.thumbnailImg(uploadPath + "/lecturer/", fileName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}



		member.setPhoneNumber(AES256.encrypt(member.getPhoneNumber()));
		member.setAddress(AES256.encrypt(member.getAddress()));
		member.setEmail(AES256.encrypt(member.getEmail()));

		memberService.updateAction(member);
		PageUtil.alertAndRedirect("./memberCertify", "수정이 완료되었습니다.", response);
	}


	@RequestMapping(value="updateAction1", method=RequestMethod.POST)
	public void updateAction1(Member member, HttpServletResponse response,HttpSession session) {
		Member member1=(Member) session.getAttribute("userSession");
		String id = member1.getId();

		log.debug(id);
		member.setId(id);

		member.setPhoneNumber(AES256.encrypt(member.getPhoneNumber()));
		member.setAddress(AES256.encrypt(member.getAddress()));
		member.setEmail(AES256.encrypt(member.getEmail()));

		memberService.updateAction1(member);
		PageUtil.alertAndRedirect("./memberCertify", "수정이 완료되었습니다.", response);
	}

	@RequestMapping(value = "passwordUpdate")
	public String passwordUpdate() {
		return "/mypage/member/passwordUpdate";
	}

	@RequestMapping(value = "passwordUpdateAction", method = RequestMethod.POST)
	public void passwordUpdateAction(Member member, HttpSession session, HttpServletResponse response) {
		Member member1=(Member) session.getAttribute("userSession");
		String id = member1.getId();

		String password = member.getPassword();

		String encPassword = passwordEncoder.encode(password);

		member.setPassword(encPassword);
		member.setId(id);

		memberService.passwordUpdate(member);

		PageUtil.alertAndRedirect("/mypage/offline/close", "수정이 완료되었습니다.", response);
	}

	@RequestMapping(value = "deleteMember")
	public String deleteMember(Member member, HttpSession session) {
		member=(Member) session.getAttribute("userSession");
		memberService.deleteMember(member);

		return "redirect:/member/logout";
	}
}
