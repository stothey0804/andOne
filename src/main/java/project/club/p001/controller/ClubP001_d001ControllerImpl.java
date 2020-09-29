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

import project.club.p001.service.ClubP001_d001Service;
import project.club.p001.vo.ClubP001_d001VO;

@Controller
public class ClubP001_d001ControllerImpl implements ClubP001_d001Controller{
	@Autowired
	ClubP001_d001Service clubP001_d001Service;
	@Autowired
	ClubP001_d001VO p001_d001;
	
	@Override
	@RequestMapping(value="/club/clubMain.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView clubMain() throws Exception{
		List<ClubP001_d001VO> clubList = clubP001_d001Service.clubList();
		List<ClubP001_d001VO> myClubList = clubP001_d001Service.myClubList();
		ModelAndView mav = new ModelAndView("clubMain");
		mav.addObject("clubList",clubList);
		mav.addObject("myClubList",myClubList);
		mav.addObject("myClubCnt", myClubList.size());
		
		return mav;
	}
	
	@Override
	@RequestMapping(value="/club/p001/searchClub.do",method= {RequestMethod.POST})
	public ModelAndView searchClubList(@RequestParam(value="searchWord", required=false) String searchWord) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("searchWord", "%"+searchWord+"%");
		List<ClubP001_d001VO> list = clubP001_d001Service.searchClubList(searchMap);
		ModelAndView mav = new ModelAndView("searchList");
		mav.addObject("resultList",list);
		mav.addObject("cnt", list.size());
		mav.addObject("searchWord",searchWord); 
		return mav;
	}
	
	@RequestMapping(value="/detailClub.do",method= {RequestMethod.GET})
	public ModelAndView detailClub(@RequestParam(value="c_id",required = true) String c_id) throws Exception{
		System.out.println(c_id);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id", c_id);
		ClubP001_d001VO vo = clubP001_d001Service.detailClub(searchMap);
		ModelAndView mav = new ModelAndView("detailClub");
		mav.addObject("clubInfo", vo);
		return mav;
	}
}
