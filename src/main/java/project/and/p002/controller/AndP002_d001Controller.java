package project.and.p002.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

public interface AndP002_d001Controller {
	public ModelAndView insertAndOnePage(HttpServletRequest request);
	public String insertAndOne(Map<String,Object> Andone, HttpServletRequest request);
	public String deleteAndOne(String one_id);
}
