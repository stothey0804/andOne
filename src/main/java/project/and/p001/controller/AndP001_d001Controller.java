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
public ModelAndView searchAndOneList(Map<String, Object> searchMap, HttpSession session) throws Exception;
public ModelAndView andOneMain(String g_id, Cookie latCookie, Cookie lngCookie, HttpSession session) throws Exception;
public ModelAndView andOneDetail(Map<String, Object> detailMap, HttpSession session) throws Exception;
public String addOneMember(Map<String, Object> addMemMap, HttpSession session) throws Exception;
}
