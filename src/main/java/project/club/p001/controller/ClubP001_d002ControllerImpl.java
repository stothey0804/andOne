package project.club.p001.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Pagination;
import common.dao.CommonDAO;
import project.club.p001.service.ClubP001_d002Service;
import project.club.vo.ClubVO;

@Controller
public class ClubP001_d002ControllerImpl implements ClubP001_d002Controller{
	@Autowired
	ClubP001_d002Service clubP001_d002Service;
	@Autowired
	ClubVO vo;
	@Autowired
	CommonDAO commonDAO;

	@Override
	@RequestMapping(value="/admin/searchClubList.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView searchClubListAdmin(@RequestParam(defaultValue = "1") int curPage,ClubVO clubVO,@RequestParam Map<String, Object> searchMap) {
		List<HashMap<String, String>> category = commonDAO.searchCommonCodeList("019");
		if(clubVO.getC_category()==null) {
			searchMap.put("c_category", "%");
		} else {
			searchMap.put("c_category", "%"+clubVO.getC_category());
		}
		if(searchMap.get("select") == null) {
			searchMap.put("select","");
		}
		if(searchMap.get("keyword") == null) {
			searchMap.put("keyword","");
		}
		int clubCnt = clubP001_d002Service.clubCnt(searchMap);
		Pagination pagination = new Pagination(clubCnt, curPage);
		searchMap.put("startIndex",(pagination.getStartIndex()+1)+"");
		searchMap.put("endIndex", (pagination.getStartIndex()+pagination.getPageSize())+"");
		List<ClubVO> clubList = clubP001_d002Service.clubList(searchMap);
		
		ModelAndView mav = new ModelAndView("ClubP001_d002_search");
		mav.addObject("clubList", clubList);
		mav.addObject("pagination", pagination);
		mav.addObject("category", category);
		return mav;
	}
}
