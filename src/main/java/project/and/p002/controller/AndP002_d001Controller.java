package project.and.p002.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface AndP002_d001Controller {
	public ModelAndView insertAndOnePage(HttpServletRequest request);
	public void insertAndOne(Map<String,Object> Andone);
}
