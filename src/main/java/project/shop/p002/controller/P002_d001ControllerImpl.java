package project.shop.p002.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project.shop.p002.service.P002_d001Service;
import project.shop.p002.vo.P002ShopDetailVO;

@Controller
public class P002_d001ControllerImpl implements P002_d001Controller {
	@Autowired
	P002ShopDetailVO p002ShopDetailVO;
	@Autowired
	P002_d001Service p002_d001Service;
	
	@RequestMapping("/shop/localShopMain.do")
	public String localShopMain(P002ShopDetailVO vo, Model model) {
		
		return "test";
	}
	
	@RequestMapping("/shop/localShopSearch.do")
	public String localShopSearch(P002ShopDetailVO vo, Model model) {
		
		return "test";
	}
	
	@RequestMapping("/shop/localShopSearchByFilter.do")
	public String localShopSearchByFilter(P002ShopDetailVO vo, Model model) {
		
		return "test";
	}
	
	public List<P002ShopDetailVO> getShopList(P002ShopDetailVO vo){
		return p002_d001Service.getShopList(vo);
	}
	
	public P002ShopDetailVO getShopDetail(P002ShopDetailVO vo) {
		return p002_d001Service.getShopDetail(vo);
	}
	
}
