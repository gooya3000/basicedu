package site.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import site.member.Member;

public class UserSessionUtil {

	static Logger log = LoggerFactory.getLogger(UserSessionUtil.class);

	static String sessionId = "userSession";

	public static boolean isLogin() {
		Object obj = getAttribute(sessionId);
		if (obj != null) {
			return true;
		} else {
			return false;
		}
	}

	public static Object getAttribute(String key) {
		return RequestContextHolder.currentRequestAttributes().getAttribute(key, RequestAttributes.SCOPE_SESSION);
	}

	public static Member getUserSession() {
		if (isLogin()) {
			return (Member) getAttribute(sessionId);
		} else {
			return null;
		}
	}

}
