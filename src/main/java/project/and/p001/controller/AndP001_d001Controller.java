package project.and.p001.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface AndP001_d001Controller{
	public ModelAndView searchList_eat(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView searchList_do(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView searchList_buy(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
