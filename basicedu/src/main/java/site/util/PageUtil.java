package site.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PageUtil {

	static Logger log = LoggerFactory.getLogger(PageUtil.class);

	public static void alertAndRedirect(String url, String msg, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('"+ msg +"'); location.href='"+ url +"';</script>");
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void redirect(String url, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>location.href='"+ url +"';</script>");
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
