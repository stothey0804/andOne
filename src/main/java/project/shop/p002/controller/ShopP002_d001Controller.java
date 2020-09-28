package project.shop.p002.controller;

import java.util.List;

import org.springframework.ui.Model;

import project.shop.p002.vo.ShopP002ShopDetailVO;

public interface ShopP002_d001Controller {
	public String localShopMain(ShopP002ShopDetailVO vo, Model model);
	public String localShopSearch(ShopP002ShopDetailVO vo, Model model);
	public List<ShopP002ShopDetailVO> FilteringByAjax(ShopP002ShopDetailVO vo, Model model);
}
