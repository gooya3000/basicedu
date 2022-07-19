package site.member.handler;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import site.member.Member;
import site.member.MemberService;

public class UserLoginSuccessHandler implements AuthenticationSuccessHandler {

	static Logger log = LoggerFactory.getLogger(UserLoginSuccessHandler.class);

	@Resource(name="MemberService")
	MemberService memberService;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		log.debug("UserLoginSuccessHandler name : " + authentication.getName());

		Member param = new Member();
		param.setId(authentication.getName());

		HttpSession session = request.getSession();
		session.setAttribute("userSession", memberService.findMember(param));

		String url = "/";

		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);

        if(savedRequest != null) {
            url = savedRequest.getRedirectUrl();
        } else {
        	String prevPage = (String) request.getSession().getAttribute("prevPage");
        	if (StringUtils.hasText(prevPage) && (prevPage.indexOf("/member/") == -1)) {
				url = prevPage;
			}
        }

		response.sendRedirect(url);
	}
}
