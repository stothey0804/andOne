package project.root.p001.contoller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

public interface P001_d001Controller {
	public ModelAndView searchInit(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
