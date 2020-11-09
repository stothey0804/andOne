package project.shop.p001.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project.shop.p001.service.ShopP001_d004Service;
import project.shop.p001.service.ShopP001_d005Service;
import project.shop.p001.vo.ShopP001StatisticsVO;
import project.shop.p002.service.ShopP002_d001Service;
import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p003.service.ShopP003_d001Service;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Controller
public class ShopP001_d004ControllerImpl implements ShopP001_d004Controller{
	
	@Autowired
	ShopP001_d004Service shopP001_d004Service;
	@Autowired
	ShopP002_d001Service shopP002_d001Service;
	@Autowired
	ShopP003_d001Service shopP003_d001Service;
	
	// 지역업체 관리 옮겨오기
	@Autowired
	ShopP001_d005Service shopP001_d005Service;
	
	//로그인성공
		@RequestMapping(value="biz/loginOk.do")
		public String loginOk(HttpServletRequest request, Model model) {
			String path = "";
			HttpSession session = request.getSession(false);
			
			boolean result = false;
			if(session!=null) {
				if(session.getAttribute("bm_id")!=null && session.getAttribute("isLogOn")!=null){
					result = true;
				}
			}
			// 로그인세션 존재시
			if(result) {
				ShopP002ShopDetailVO resultVO = new ShopP002ShopDetailVO();
				resultVO.setSearchCondition("SEARCHBYBMID");
				resultVO.setBm_id((String)session.getAttribute("bm_id"));
				Map<String,Object> param = new HashMap<>();
				param.put("vo", resultVO);
				resultVO = shopP002_d001Service.getShopDetail(param);
				
				
				if(resultVO == null) {
					model.addAttribute("isNull",true);
				}else {
					Map<String,String> reviewParam = new HashMap<>();
					String s_id = resultVO.getS_id();
					reviewParam.put("s_id", s_id);
					reviewParam.put("startIndex", "1");
					reviewParam.put("endIndex", "3");
					reviewParam.put("isAll","true");
					List<ShopP003ShopReviewVO> reviewList = shopP003_d001Service.getShopReviewListByPaging(reviewParam);
					resultVO.setShopReviewList(reviewList);
					shopP002_d001Service.shopImageEncoder(resultVO);
					for(int i=0; i<resultVO.getShopReviewList().size();i++) {
						shopP002_d001Service.reviewImageEncoder(resultVO.getShopReviewList().get(i));
					}
					ShopP001StatisticsVO reviewStatistics = shopP001_d004Service.sixMonthReviewStatistics(s_id);
					ShopP001StatisticsVO scoreStatistics = shopP001_d004Service.sixMonthScoreStatistics(s_id);
					model.addAttribute("resultVO",resultVO);
					model.addAttribute("reviewStatistics",reviewStatistics);
					model.addAttribute("scoreStatistics",scoreStatistics);
					model.addAttribute("isNull",false);
				}
				path = "shopAdminMain";
			}else {
				path = "redirect:loginPage.do";
			}
			return path; //업체 관리자 페이지이동
		}
}
