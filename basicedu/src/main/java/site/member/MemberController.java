package site.member;

import java.util.Random;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import site.util.AES256Util;
import site.util.PageUtil;
import site.util.Param;

@Controller
@RequestMapping("/member")
public class MemberController {

	static Logger log = LoggerFactory.getLogger(MemberController.class);

	public BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	public AES256Util AES256 = new AES256Util();

	@Resource(name = "MemberService")
	MemberService memberService;

	@Autowired
	JavaMailSender mailSender;

	@RequestMapping("login")
	public String login(HttpServletRequest request) {
		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("prevPage", referer);

		return "/member/login";
	}

	@RequestMapping("join")
	public String join() {
		return "/member/join";
	}

	@RequestMapping(value = "kakaoJoin", method = RequestMethod.POST)
	public String kakaoJoin(Member member, Model model) {
		log.debug(member.getId() + "         " + member.getEmail() + "           " + member.getName());
		model.addAttribute("id", member.getId());
		model.addAttribute("name", member.getName());
		return "/member/kakaoJoin";
	}

	@RequestMapping("nomalJoin")
	public String nomalJoin() {
		return "/member/nomalJoin";
	}

	@ResponseBody
	@RequestMapping(value = "nomalJoin", method = RequestMethod.POST)
	public ModelAndView sendMail(Member member) {

		Random r = new Random();
		int dice = r.nextInt(4589362) + 49311; // 이메일로 받는 인증코드 부분 (난수)

		String setfrom = "yhlim95122@gamil.com";
		String tomail = member.getEmail(); // 받는 사람 이메일
		String title = "회원가입 인증 이메일 입니다."; // 제목
		String content =

				System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성

						System.getProperty("line.separator") +

						"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"

						+ System.getProperty("line.separator") +

						System.getProperty("line.separator") +

						" 인증번호는 " + dice + " 입니다. "

						+ System.getProperty("line.separator") +

						System.getProperty("line.separator") +

						"받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/member/nomalJoin");
		mv.addObject("emailCode", dice);
		mv.addObject("member", member);
		System.out.println(mv);
		System.out.println(dice);
		return mv;
	}

	@RequestMapping(value = "joinAction", method = RequestMethod.POST)
	public void joinAction(Member member, HttpServletResponse response) {
		String password = member.getPassword();
		log.debug("password : " + password);
		String encPassword = passwordEncoder.encode(password);
		log.debug("encPassword : " + encPassword);
		member.setPassword(encPassword);
		member.setPhoneNumber(AES256.encrypt(member.getPhoneNumber()));
		member.setAddress(AES256.encrypt(member.getAddress()));
		member.setEmail(AES256.encrypt(member.getEmail()));

		memberService.saveMember(member);
		PageUtil.alertAndRedirect("/", "회원가입이 완료되었습니다.", response);
	}

	@ResponseBody
	@RequestMapping("idCheck")
	public String idCheck(Member member) {
		String result = "success";

//		Param param = new Param();
//		param.setKeyword(member.getId());
		member = memberService.findMember(member);
		if (member != null) {
			result = "fail";
		}

		return result;
	}

}