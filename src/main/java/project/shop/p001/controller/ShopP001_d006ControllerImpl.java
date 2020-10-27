package project.shop.p001.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import common.Pagination;
import project.shop.p001.service.ShopP001_d005Service;
import project.shop.p001.service.ShopP001_d006Service;
import project.shop.p002.service.ShopP002_d001Service;
import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;
import project.shop.p003.service.ShopP003_d001Service;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Controller
public class ShopP001_d006ControllerImpl implements ShopP001_d006Controller{
	
	@Autowired
	private ShopP001_d006Service shopP001_d006Service;
	@Autowired
	private ShopP001_d005Service shopP001_d005Service;
	@Autowired
	private ShopP003_d001Service shopP003_d001Service;
	@Autowired
	private ShopP002_d001Service shopP002_d001Service;
	
	@RequestMapping("biz/crudInit.do")
	public String crudInit(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		String bm_id = (String)session.getAttribute("bm_id");
		model.addAttribute("bm_id",bm_id);
		String s_id = shopP001_d005Service.getShopIdByBmemberId(bm_id);
		if(s_id==null || s_id.equals("")) {
			model.addAttribute("s_id","isNull");
		}else {
			model.addAttribute("s_id", s_id);
		}
		return "crudInit";
	}
	
	@RequestMapping("biz/crudController.do")
	public String crudController(@RequestParam String bm_id, @RequestParam String s_id,
			@RequestParam String path, Model model) {
		model.addAttribute("bm_id",bm_id);
		model.addAttribute("s_id",s_id);
		return path;
	}
	
	@RequestMapping("biz/deleteShopComplete.do")
	public String deleteMemberComplete(@RequestParam String s_id) {
		shopP001_d005Service.deleteShop(s_id);
		shopP002_d001Service.popularHashtagUpdate();
		return "deleteShopComplete";
	}
	
	@ResponseBody
	@RequestMapping("biz/deleteShopImage.do")
	public void deleteShopImage(@RequestParam String s_id) {
		shopP001_d005Service.deleteShopImage(s_id);
	}
	
	@RequestMapping("biz/insertShop.do")
	public String insertShop(MultipartHttpServletRequest mtfRequest, ShopP002ShopDetailVO shopVO) {
		List<MultipartFile> fileList = mtfRequest.getFiles("image");
		for(int i=0; i<fileList.size(); i++) {
			System.out.println("==================================");
			System.out.println("file name : " + fileList.get(i).getOriginalFilename());
			System.out.println("file size : "+fileList.get(i).getSize());
			System.out.println("==================================");
		}
		System.out.println("====> 사업자번호 : "+shopVO.getS_id());
		System.out.println("====> 카테고리 : "+shopVO.getS_category());
		System.out.println("====> 가게이름 : "+shopVO.getS_name());
		System.out.println("====> 가게점수 : "+shopVO.getS_score());
		System.out.println("====> 가게소개 : "+shopVO.getS_content());
		System.out.println("====> 업주 아이디 : "+shopVO.getBm_id());
		System.out.println("====> 위치정보 : "+shopVO.getS_locate());
		System.out.println("====> 가게전화번호 : "+shopVO.getS_phoneNumber());
		System.out.println("====> 해시태그 : "+shopVO.getS_hashtag());
		/*	s_id : 입력받은 데이터 vo에서 get
		 *	s_category : 입력받은 데이터 vo에서 get
		 *	s_name : 입력받은 데이터 vo에서 get
		 *	s_score : 입력받은 데이터 vo에서 get(타입 히든 - 0으로 고정)
		 *	s_content : 입력받은 데이터 vo에서 get
		 *	bm_id : 입력받은 데이터 vo에서 get(타입 히든 - 로그인중인 아이디)
		 *	s_locate : 입력받은 데이터 vo에서 get(현재 임시로 더미값 히든으로 넣고있음)
		 *	s_phonenumber : 입력받은 데이터 vo에서 get
		 *	s_hashtag : 입력받은 데이터 vo에서 get
		 * */
		if(shopVO.getS_hashtag()==null) {
			shopVO.setS_hashtag("");
		}
		shopP001_d006Service.insertShop(shopVO);
		shopP002_d001Service.popularHashtagUpdate();
		if(fileList.get(0).getSize()!=0) {
			ShopP002ShopImageVO imageVO = new ShopP002ShopImageVO();
			imageVO.setS_id(shopVO.getS_id());
			try {
				for(int i=0; i<fileList.size(); i++) {
					Map<String,Object> map = new HashMap<String,Object>();
					map.put("img",fileList.get(i).getBytes());
					imageVO.setSi_imgEncoder(map);
					imageVO.setSi_idx((i+1)+"");
					shopP001_d006Service.insertShopImage(imageVO);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return "redirect:loginOk.do";
	}
	
	@RequestMapping("biz/modifyShop.do")
	public String modifyShop(MultipartHttpServletRequest mtfRequest, ShopP002ShopDetailVO shopVO) {
		List<MultipartFile> fileList = mtfRequest.getFiles("image");
		for(int i=0; i<fileList.size(); i++) {
			System.out.println("==================================");
			System.out.println("file name : " + fileList.get(i).getOriginalFilename());
			System.out.println("file size : "+fileList.get(i).getSize());
			System.out.println("==================================");
		}
		System.out.println("====> 사업자번호 : "+shopVO.getS_id());
		System.out.println("====> 카테고리 : "+shopVO.getS_category());
		System.out.println("====> 가게이름 : "+shopVO.getS_name());
		System.out.println("====> 가게점수 : "+shopVO.getS_score());
		System.out.println("====> 가게소개 : "+shopVO.getS_content());
		System.out.println("====> 업주 아이디 : "+shopVO.getBm_id());
		System.out.println("====> 위치정보 : "+shopVO.getS_locate());
		System.out.println("====> 가게전화번호 : "+shopVO.getS_phoneNumber());
		System.out.println("====> 해시태그 : "+shopVO.getS_hashtag());
	
		if(shopVO.getS_hashtag()==null) {
			shopVO.setS_hashtag("");
		}
		shopP001_d006Service.updateShop(shopVO);
		shopP002_d001Service.popularHashtagUpdate();
		if(fileList.get(0).getSize()!=0) {
			ShopP002ShopImageVO imageVO = new ShopP002ShopImageVO();
			imageVO.setS_id(shopVO.getS_id());
			try {
				for(int i=0; i<fileList.size(); i++) {
					imageVO.setSi_idx((i+1)+"");
					boolean dup = shopP003_d001Service.isDuplicate(imageVO);
					Map<String,Object> map = new HashMap<String,Object>();
					map.put("img",fileList.get(i).getBytes());
					imageVO.setSi_imgEncoder(map);
					if(dup) {
						shopP001_d006Service.updateShopImage(imageVO);
					}else {
						shopP001_d006Service.insertShopImage(imageVO);
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return "redirect:loginOk.do";
	}
	
	@ResponseBody
	@RequestMapping("/biz/getShopByAjax.do")
	public ShopP002ShopDetailVO getShopByAjax(ShopP002ShopDetailVO vo, Model model) {
		vo.setSearchCondition("SEARCHBYSHOPID");
		ShopP002ShopDetailVO resultVO = shopP002_d001Service.getShopDetail(vo);
		shopP002_d001Service.shopImageEncoder(resultVO);
		return resultVO;
	}
	
	@RequestMapping("biz/shopReviewList.do")
	public ModelAndView shopReviewList(@RequestParam(defaultValue="1")int curPage, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession(false);
		String bm_id = (String)session.getAttribute("bm_id");
		String s_id = shopP001_d005Service.getShopIdByBmemberId(bm_id);
		int listCnt = 0;
		listCnt = shopP003_d001Service.selectShopReviewListCnt(s_id);
		Pagination pagination = new Pagination(listCnt, curPage);
		Map<String, String> searchParam = new HashMap<>();
		searchParam.put("s_id",s_id);
		searchParam.put("startIndex",(pagination.getStartIndex()+1)+"");
		searchParam.put("endIndex",(pagination.getStartIndex()+pagination.getPageSize())+"");
		List<ShopP003ShopReviewVO> reviewList = new ArrayList<>();
		reviewList = shopP003_d001Service.getShopReviewListByPaging(searchParam);
		for(int i=0; i<reviewList.size(); i++) {
			shopP002_d001Service.reviewImageEncoder(reviewList.get(i));
		}
		mav.addObject("reviewList",reviewList);
		mav.addObject("pagination",pagination);
		mav.addObject("s_id",s_id);
		mav.addObject("reviewCount",listCnt);
		mav.setViewName("bizShopReviewList");
		return mav;
	}
	
	@RequestMapping(value="biz/searchOverlapShopId.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void searchOverlapEmail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String shopId = request.getParameter("shopId");
		String result = shopP001_d006Service.searchOverlapShopId(shopId);
		if(result!=null) {
			out.print("true");
		}else {
			out.print("false");
		}
		out.close();
	}
	
	@RequestMapping(value="biz/searchOverlapShopPhone.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void searchOverlapPhone(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String phone = request.getParameter("phone");
		// 이메일 중복 체크 조회 쿼리
		String result = shopP001_d006Service.searchOverlapShopPhone(phone);
		if(result!=null) {
			out.print("true"); 	// 중복
		}else {
			out.print("false");
		}
		out.close();
	}
}
