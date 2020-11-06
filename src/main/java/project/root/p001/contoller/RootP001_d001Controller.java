package project.root.p001.contoller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface RootP001_d001Controller {
	public ModelAndView searchInit(Cookie latCookie, Cookie lngCookie, HttpServletRequest request,
			HttpServletResponse response) throws Exception;
}
