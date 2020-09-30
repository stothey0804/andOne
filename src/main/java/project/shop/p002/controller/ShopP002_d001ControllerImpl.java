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
		return "localShopMain";
	}
	
	@RequestMapping("/shop/localShopSearch.do")
	public String localShopSearch(ShopP002ShopDetailVO vo, Model model) {
		model.addAttribute("usedKeyword",vo.getSearchKeyword());
		model.addAttribute("filter",vo.getFilter());
		return "localShopSearch";
	}
	
	@RequestMapping("/shop/localShopDetail.do")
	public String localShopDetail(ShopP002ShopDetailVO vo, Model model) {
		model.addAttribute("shopId",vo.getS_id());
		return "localShopDetail";
	}
	
	@ResponseBody
	@RequestMapping("/shop/getShopDetailByAjax.do")
	public ShopP002ShopDetailVO getShopDetailByAjax(ShopP002ShopDetailVO vo, Model model) {
		vo.setSearchCondition("SEARCHBYSHOPID");
		return getShopDetail(vo);
	}
	@ResponseBody
	@RequestMapping("/shop/popularSearchByAjax.do")
	public List<ShopP002ShopDetailVO> popularSearchByAjax(ShopP002ShopDetailVO vo, Model model) {
		vo.setSearchCondition("POPULAR");
		vo.setStatus("REVIEW");
		return getShopList(vo);
	}
	
	@ResponseBody
	@RequestMapping("/shop/searchByAjax.do")
	public List<ShopP002ShopDetailVO> searchByAjax(ShopP002ShopDetailVO vo, Model model) {
		if(vo.getFilter().equals("all") ||  vo.getFilter().equals("") || vo.getFilter()==null) {
			vo.setSearchCondition("ALLSEARCH");
		}else {
			vo.setSearchCondition("SEARCHBYFILTER");
		}
		if(vo.getSearchKeyword()==null) {
			vo.setSearchKeyword("");
		}
		if(vo.getStatus()==null) {
			vo.setStatus("SCORE");
		}
		return getShopList(vo);
	}
	
	public List<ShopP002ShopDetailVO> getShopList(ShopP002ShopDetailVO vo){
		return shopP002_d001Service.getShopList(vo);
	}
	
	public ShopP002ShopDetailVO getShopDetail(ShopP002ShopDetailVO vo) {
		return shopP002_d001Service.getShopDetail(vo);
	}
	
}
