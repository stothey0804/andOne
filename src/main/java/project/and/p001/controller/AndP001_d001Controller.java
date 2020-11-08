package project.and.p001.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.and.vo.AndP001AndOneVO;

public interface AndP001_d001Controller{
	public ModelAndView andOneMain(Map<String, Object> mainMap, Cookie latCookie, Cookie lngCookie, HttpServletRequest requestn) throws Exception;
	public ModelAndView andOneDetail(Map<String, Object> detailMap, HttpServletRequest request) throws Exception;
	public String addOneMember(Map<String,Object> addMap, HttpServletRequest request) throws Exception;
	public ModelAndView searchAndOneList(Map<String, Object> searchMap,int curPage, Cookie latCookie, Cookie lngCookie,
			HttpServletRequest request) throws Exception;
	public String searchMoreAndOne(Map<String,Object> searchMap) throws Exception;
}
