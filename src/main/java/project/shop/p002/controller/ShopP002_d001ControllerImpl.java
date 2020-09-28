package project.shop.p002.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import project.shop.p002.service.ShopP002_d001Service;
import project.shop.p002.vo.ShopP002ShopDetailVO;

@Controller
public class ShopP002_d001ControllerImpl implements ShopP002_d001Controller {
	@Autowired
	ShopP002ShopDetailVO shopP002ShopDetailVO;
	@Autowired
	ShopP002_d001Service shopP002_d001Service;
	
	@RequestMapping("/shop/localShopMain.do")
	public String localShopMain(ShopP002ShopDetailVO vo, Model model) {
		if(vo.getSearchCondition()==null) {
			vo.setSearchCondition("ALLSEARCH");
		}
		if(vo.getSearchKeyword()==null) {
			vo.setSearchKeyword("");
		}
		List<ShopP002ShopDetailVO> shopList = getShopList(vo);
		model.addAttribute("shopList",shopList);
		return "localShopMain";
	}
	
	@RequestMapping("/shop/localShopSearch.do")
	public String localShopSearch(ShopP002ShopDetailVO vo, Model model) {
		if(vo.getFilter()!=null) {
			vo.setSearchCondition("SEARCHBYFILTER");
		}else if(vo.getSearchCondition()==null) {
			vo.setSearchCondition("ALLSEARCH");
		}
		if(vo.getSearchKeyword()==null) {
			vo.setSearchKeyword("");
		}
		List<ShopP002ShopDetailVO> shopList = getShopList(vo);
		model.addAttribute("shopList",shopList);
		model.addAttribute("usedKeyword",vo.getSearchKeyword());
		return "localShopSearch";
	}
	
	@ResponseBody
	@RequestMapping("/shop/filteringByAjax.do")
	public List<ShopP002ShopDetailVO> FilteringByAjax(ShopP002ShopDetailVO vo, Model model) {
		if(vo.getFilter().equals("all") || vo.getFilter()==null) {
			vo.setSearchCondition("ALLSEARCH");
		}else {
			vo.setSearchCondition("SEARCHBYFILTER");
		}
		if(vo.getSearchKeyword()==null) {
			vo.setSearchKeyword("");
		}
		return getShopList(vo);
	}
	
	public List<ShopP002ShopDetailVO> getShopList(ShopP002ShopDetailVO vo){
		return shopP002_d001Service.getShopList(vo);
	}
	
}
