package project.shop.p001.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;

import project.shop.p001.vo.ShopP001BmemberVO;

public interface ShopP001_d002Controller {
	public String loginPage(HttpServletRequest request);
	public int login(@ModelAttribute ShopP001BmemberVO vo, HttpSession session, HttpServletRequest request, HttpServletResponse response);
	public String logout(HttpSession session);
}
