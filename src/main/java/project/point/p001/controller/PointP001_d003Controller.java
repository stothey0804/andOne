package project.point.p001.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface PointP001_d003Controller {
	public ModelAndView pointPay(Map<String, Object> payMap, HttpServletRequest request);

}
