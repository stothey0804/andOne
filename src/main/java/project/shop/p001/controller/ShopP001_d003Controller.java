package project.shop.p001.controller;

import org.springframework.web.bind.annotation.ModelAttribute;

import project.shop.p001.vo.ShopP001BmemberVO;

public interface ShopP001_d003Controller {
	public String findInfo();
	public String findId(@ModelAttribute ShopP001BmemberVO vo ) throws Exception;

}
