package project.shop.p003.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import project.shop.p002.service.ShopP002_d001Service;
import project.shop.p003.service.ShopP003_d001Service;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Controller
public class ShopP003_d001ControllerImpl implements ShopP003_d001Controller{

	@Autowired
	ShopP003_d001Service shopP003_d001Service;
	
	@Autowired
	ShopP002_d001Service shopP002_d001Service;
	
	@RequestMapping("/shop/writeShopReview.do")
	public String writeShopReview(HttpServletRequest request, ShopP003ShopReviewVO vo, Model model) {
		String path = "";
		if(loginCheck(request)) {
			vo.setM_id((String)request.getSession().getAttribute("m_id"));
			if(shopP003_d001Service.checkShopReview(vo)) {
				model.addAttribute("vo",vo);
				path = "writeShopReview";
			}else {
				path = "modifyShopReview";
			}
		}else {
			path = "member/p001_d002";
		}
		return path;
	}
	
	@RequestMapping("/shop/updateTest.do")
	public void updateTest(MultipartHttpServletRequest mtfRequest, ShopP003ShopReviewVO reviewVO) {
		List<MultipartFile> fileList = mtfRequest.getFiles("image");
		for(int i=0; i<fileList.size(); i++) {
			System.out.println("==================================");
			System.out.println("file name : " + fileList.get(i).getOriginalFilename());
			System.out.println("file size : "+fileList.get(i).getSize());
			System.out.println("==================================");
		}
		System.out.println(reviewVO.getM_id());
		System.out.println(reviewVO.getS_id());
		System.out.println(reviewVO.getSr_content());
		System.out.println(reviewVO.getSr_score());
		// VO로 s_review 테이블 insert. sr_date, sr_public은 쿼리문에서 임의로 삽입 -> 'sysdate', '1'
		// fileList로 포문 돌려서 si_image 테이블 insert. m_id, s_id는 VO가 들고 있는 값 삽입.
		// list의 인덱스 +1을 si_idx로
		shopP003_d001Service.insertShopReview(reviewVO);
		if(fileList.size()!=0) {
			ShopP003ShopReviewImageVO reviewImageVO = new ShopP003ShopReviewImageVO();
			reviewImageVO.setM_id(reviewVO.getM_id());
			reviewImageVO.setS_id(reviewVO.getS_id());
			try {
				for(int i=0; i<fileList.size(); i++) {
					Map<String,Object> map = new HashMap<String,Object>();
					map.put("img",fileList.get(i).getBytes());
					reviewImageVO.setRi_imgEncoder(map);
					reviewImageVO.setRi_idx((i+1)+"");
					shopP003_d001Service.insertShopReviewImage(reviewImageVO);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	public boolean loginCheck(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		boolean result = false;
		if(session!=null) {
			if(session.getAttribute("m_id")!=null && session.getAttribute("isLogOn")!=null){
				result = true;
			}
		}
		return result;
	}
}
