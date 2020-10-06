package project.shop.p001.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.shop.p001.vo.ShopP001BmemberVO;

public interface ShopP001_d001Controller {
	public String init();
	public String joinform();
	public int idCheck(@RequestParam("bm_id") String bm_id) throws Exception;
	public int emailCheck(@RequestParam("bm_email") String bm_email) throws Exception;
	public String addMember(@ModelAttribute("bMember") ShopP001BmemberVO shopP001_d001VO) throws Exception;
}
