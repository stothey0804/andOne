package project.shop.p002.controller;

import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import project.shop.p002.service.ShopP002_d001Service;
import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;
import project.shop.p003.service.ShopP003_d001Service;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Controller
public class ShopP002_d001ControllerImpl implements ShopP002_d001Controller {
	@Autowired
	ShopP002ShopDetailVO shopP002ShopDetailVO;
	@Autowired
	ShopP002_d001Service shopP002_d001Service;
	@Autowired
	ShopP003_d001Service shopP003_d001Service;
	
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
	public String localShopDetail(ShopP002ShopDetailVO vo, Model model, HttpServletRequest request) {
		if(shopP003_d001Service.loginCheck(request)) {
			model.addAttribute("loginCheck",true);
		}else {
			model.addAttribute("loginCheck",false);
		}
		model.addAttribute("shopId",vo.getS_id());
		return "localShopDetail";
	}
	
	@RequestMapping("/shop/popularHashtagUpdate.do")
	public String popularHashtagUpdate() {
		List<String> hashtagList = shopP002_d001Service.getAllHashtag();
		Map<String,Integer> hashtagMap = new HashMap<>();
		for(int i=0; i<hashtagList.size(); i++) {
			String[] parser = hashtagList.get(i).split(",");
			for(int j=0; j<parser.length; j++) {
				if(parser[j].equals("")) {
					continue;
				}else {
					if(hashtagMap.containsKey(parser[j])) {
						int value = (int)hashtagMap.get(parser[j]);
						value++;
						hashtagMap.replace(parser[j], value);
					}else {
						hashtagMap.put(parser[j], 1);
					}
				}
			}
		}
		List<String> keySetList = new ArrayList<>(hashtagMap.keySet());
		System.out.println("======> 정렬 전 입력된 값 확인");
		for(int i=0; i<keySetList.size(); i++) {
			System.out.println("해시태그 : #" + keySetList.get(i) + "  /  횟수 : " + hashtagMap.get(keySetList.get(i)));
		}
		Collections.sort(keySetList, (o1, o2) -> (hashtagMap.get(o2).compareTo(hashtagMap.get(o1))));
		System.out.println("======> 정렬 후 입력된 값 확인");
		for(int i=0; i<keySetList.size(); i++) {
			System.out.println("해시태그 : #" + keySetList.get(i) + "  /  횟수 : " + hashtagMap.get(keySetList.get(i)));
		}
		System.out.println("======>상위 4개 해시태그만 printout");
		String result = "";
		for(int i=0; i<4; i++) {
			result += keySetList.get(i);
			System.out.println("#"+keySetList.get(i));
			result += ",";
		}
		result = result.substring(0, result.length()-1);
		System.out.println("=======>DB에 들어갈 인기 해시태그");
		System.out.println(result);
		shopP002_d001Service.updatePopularHashtag(result);
		return "redirect:localShopMain.do";
	}
	
	@ResponseBody
	@RequestMapping(value="/shop/getPopularHashtag.do", produces="text/plain;charset=UTF-8")
	public String getPopularHashtag() {
		return shopP002_d001Service.getPopularHashtag();
	}
	
	@ResponseBody
	@RequestMapping("/shop/getShopDetailByAjax.do")
	public ShopP002ShopDetailVO getShopDetailByAjax(ShopP002ShopDetailVO vo, Model model) {
		vo.setSearchCondition("SEARCHBYSHOPID");
		ShopP002ShopDetailVO resultVO = getShopDetail(vo);
		String s_id = resultVO.getS_id();
		List<String> memberIdList = shopP002_d001Service.getMemberIdFromShopReview(s_id);
		int count = memberIdList.size();
		if(count>3) {
			count = 3;
		}
		List<ShopP003ShopReviewVO> reviewList = new ArrayList<>();
		for(int i=0; i<count; i++) {
			ShopP003ShopReviewVO reviewVO = new ShopP003ShopReviewVO();
			reviewVO.setS_id(s_id);
			reviewVO.setM_id(memberIdList.get(i));
			reviewList.add(shopP002_d001Service.getShopReview(reviewVO));
		}
		resultVO.setShopReviewList(reviewList);
		shopP002_d001Service.shopImageEncoder(resultVO);
		for(int i=0; i<resultVO.getShopReviewList().size();i++) {
			shopP002_d001Service.reviewImageEncoder(resultVO.getShopReviewList().get(i));
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
			shopP002_d001Service.shopImageEncoder(resultList.get(i));
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
			shopP002_d001Service.shopImageEncoder(resultList.get(i));
		}
		return resultList;
	}
	
	@ResponseBody
	@RequestMapping("/shop/shopReviewPopup.do")
	public ShopP003ShopReviewVO shopReviewPopup(ShopP003ShopReviewVO vo, Model model) {
		ShopP003ShopReviewVO resultVO = getShopReview(vo);
		shopP002_d001Service.reviewImageEncoder(resultVO);
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
