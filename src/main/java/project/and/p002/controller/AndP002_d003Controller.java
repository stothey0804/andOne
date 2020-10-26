package project.and.p002.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface AndP002_d003Controller {
	public ModelAndView searchWroteAndOne(int curPage, HttpServletRequest request);
	public ModelAndView searchParticipateAndOne(int curPage, HttpServletRequest request);

}
