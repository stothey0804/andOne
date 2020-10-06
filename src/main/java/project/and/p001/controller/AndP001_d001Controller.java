package project.and.p001.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.and.p001.vo.AndP001AndOneVO;

public interface AndP001_d001Controller{
	public ModelAndView search_eat(@RequestParam("g_id") String g_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView searchList_eat(@ModelAttribute AndP001AndOneVO vo, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
