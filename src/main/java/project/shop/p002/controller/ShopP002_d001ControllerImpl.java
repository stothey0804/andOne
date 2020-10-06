package project.shop.p002.controller;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import project.shop.p002.service.ShopP002_d001Service;
import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

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
		ShopP002ShopDetailVO resultVO = getShopDetail(vo);
		shopImageEncoder(resultVO);
		for(int i=0; i<resultVO.getShopReviewList().size();i++) {
			reviewImageEncoder(resultVO.getShopReviewList().get(i));
		}
		return resultVO;
	}
	@ResponseBody
	@RequestMapping("/shop/popularSearchByAjax.do")
	public List<ShopP002ShopDetailVO> popularSearchByAjax(ShopP002ShopDetailVO vo, Model model) {
		vo.setSearchCondition("POPULAR");
		vo.setStatus("REVIEW");
		List<ShopP002ShopDetailVO> resultList = getShopList(vo);
		for(int i=0; i<resultList.size(); i++) {
			shopImageEncoder(resultList.get(i));
		}
		return resultList;
	}
	
	@ResponseBody
	@RequestMapping("/shop/searchByAjax.do")
	public List<ShopP002ShopDetailVO> searchByAjax(ShopP002ShopDetailVO vo, Model model) {
		if(vo.getSearchCondition()==null) {
			if(vo.getFilter().equals("all") ||  vo.getFilter().equals("") || vo.getFilter()==null) {
				vo.setSearchCondition("ALLSEARCH");
			}else {
				vo.setSearchCondition("SEARCHBYFILTER");
			}
		}
		if(vo.getSearchKeyword()==null) {
			vo.setSearchKeyword("");
		}
		if(vo.getStatus()==null) {
			vo.setStatus("SCORE");
		}
		List<ShopP002ShopDetailVO> resultList = getShopList(vo);
		for(int i=0; i<resultList.size(); i++) {
			shopImageEncoder(resultList.get(i));
		}
		return resultList;
	}
	
	@ResponseBody
	@RequestMapping("/shop/shopReviewPopup.do")
	public ShopP003ShopReviewVO shopReviewPopup(ShopP003ShopReviewVO vo, Model model) {
		ShopP003ShopReviewVO resultVO = getShopReview(vo);
		reviewImageEncoder(resultVO);
		return resultVO;
	}
	
	
	@RequestMapping("/shop/fileTest.do")
	public String fileTest() {
		return "fileTest";
	}
	
	@RequestMapping("/shop/getFile.do")
	public String getFile(ShopP002ShopImageVO vo) {
		try {
			vo.setS_id("20200917-1");
			vo.setSi_idx("3");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("img",vo.getSi_img().getBytes());
			vo.setSi_imgEncoder(map);
			shopP002_d001Service.updateShopImage(vo);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "redirect:fileTest.do";
	}
	
	@RequestMapping("/shop/updateShopReviewImage.do")
	public String updateShopReviewImage(ShopP003ShopReviewImageVO vo) {
		try {
			vo.setS_id("20200917-2");
			vo.setM_id("test2");
			vo.setRi_idx("1");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("img",vo.getRi_img().getBytes());
			vo.setRi_imgEncoder(map);
			shopP002_d001Service.updateShopReviewImage(vo);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "redirect:fileTest.do";
	}
	
	public void shopImageEncoder(ShopP002ShopDetailVO vo) {
		int shopImageCount = vo.getShopImage().size();
		for(int i=0; i<shopImageCount; i++) {
			if(!vo.getShopImage().get(i).getSi_imgEncoder().isEmpty()) {
				byte[] encoded = Base64.getEncoder().encode((byte[])vo.getShopImage().get(i).getSi_imgEncoder().get("si_imgEncoder"));
				vo.getShopImage().get(i).setSi_encodedImg(new String(encoded));
				vo.getShopImage().get(i).setSi_imgEncoder(null);
			}
		}
	}
	
	public void reviewImageEncoder(ShopP003ShopReviewVO vo) {
		int shopReviewImageCount = vo.getShopReviewImage().size();
		if(!vo.getM_imgEncoder().isEmpty()) {
			byte[] encoded1 = Base64.getEncoder().encode((byte[])vo.getM_imgEncoder().get("m_imgEncoder"));
			vo.setM_encodedImg(new String(encoded1));
			vo.setM_imgEncoder(null);
		}
		for(int i=0; i<shopReviewImageCount; i++) {
			if(!vo.getShopReviewImage().get(i).getRi_imgEncoder().isEmpty()) {
				byte[] encoded2 = Base64.getEncoder().encode((byte[])vo.getShopReviewImage().get(i).getRi_imgEncoder().get("ri_imgEncoder"));
				vo.getShopReviewImage().get(i).setRi_encodedImg(new String(encoded2));
				vo.getShopReviewImage().get(i).setRi_imgEncoder(null);
			}
		}
	}
	
	
	@ResponseBody
	@RequestMapping("/shop/viewTest.do")
	public ShopP002ShopDetailVO viewTest(ShopP002ShopDetailVO vo, Model model) {
		vo.setSearchCondition("SEARCHBYSHOPID");
		ShopP002ShopDetailVO resultVO = getShopDetail(vo);
		byte[] encoded = Base64.getEncoder().encode((byte[])resultVO.getShopImage().get(0).getSi_imgEncoder().get("si_imgEncoder"));
		resultVO.getShopImage().get(0).setSi_encodedImg(new String(encoded));
		return resultVO;
	}
	
	public ShopP003ShopReviewVO getShopReview(ShopP003ShopReviewVO vo) {
		return shopP002_d001Service.getShopReview(vo);
	}
	
	public List<ShopP002ShopDetailVO> getShopList(ShopP002ShopDetailVO vo){
		return shopP002_d001Service.getShopList(vo);
	}
	
	public ShopP002ShopDetailVO getShopDetail(ShopP002ShopDetailVO vo) {
		return shopP002_d001Service.getShopDetail(vo);
	}
	
}
