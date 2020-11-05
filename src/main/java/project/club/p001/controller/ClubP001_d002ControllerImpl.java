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
import project.club.p001.service.ClubP001_d002Service;
import project.club.vo.ClubVO;

@Controller
public class ClubP001_d002ControllerImpl implements ClubP001_d002Controller{
	@Autowired
	ClubP001_d002Service clubP001_d002Service;
	@Autowired
	ClubVO vo;

	@Override
	@RequestMapping(value="/admin/searchClubList.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView searchClubListAdmin(@RequestParam(defaultValue = "1") int curPage, @RequestParam Map<String, String> param) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		int clubCnt = clubP001_d002Service.clubCnt();
		Pagination pagination = new Pagination(clubCnt, curPage);
		searchMap.put("startIndex",(pagination.getStartIndex()+1)+"");
		searchMap.put("endIndex", (pagination.getStartIndex()+pagination.getPageSize())+"");
		List<ClubVO> clubList = clubP001_d002Service.clubList(searchMap);
		
		ModelAndView mav = new ModelAndView("ClubP001_d002_search");
		mav.addObject("clubList", clubList);
		mav.addObject("pagination", pagination);
		return mav;
	}
}
