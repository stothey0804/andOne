package project.and.p002.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface AndP002_d002Controller {
	public ModelAndView AndOnewaitMemList(String one_id);
	public String okOneMember(Map<String, Object> okMap);
	public void denyOneMember(Map<String, Object> denyMap);
	public String cancelOneMember(Map<String, Object> cancelMap, HttpServletRequest request);
	

}
