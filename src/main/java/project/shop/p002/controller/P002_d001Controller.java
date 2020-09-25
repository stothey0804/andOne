package project.shop.p002.controller;

import org.springframework.ui.Model;

import project.shop.p002.vo.P002ShopDetailVO;

public interface P002_d001Controller {
	public String localShopMain(P002ShopDetailVO vo, Model model);
	public String localShopSearch(P002ShopDetailVO vo, Model model);
	public String localShopSearchByFilter(P002ShopDetailVO vo, Model model);
}
