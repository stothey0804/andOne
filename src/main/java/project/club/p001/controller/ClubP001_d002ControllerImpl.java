package project.club.p001.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.club.p001.service.ClubP001_d002Service;
import project.club.p001.vo.ClubP001_d001articleVO;

@Controller
public class ClubP001_d002ControllerImpl implements ClubP001_d002Controller{
	@Autowired
	ClubP001_d002Service clubP001_d002Service;
	@Autowired
	ClubP001_d001articleVO p001_d001;
	
	@Override
	@RequestMapping(value="/createClub.do",method= {RequestMethod.GET})
	public ModelAndView createClub() throws Exception {
		ModelAndView mav = new ModelAndView("createClub");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/deleteClubArticle.do",method= {RequestMethod.GET})
	public ModelAndView deleteClubArticle(@RequestParam(value="ca_id",required = true) String ca_id) throws Exception {
		System.out.println(ca_id);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		clubP001_d002Service.deleteClubArticle(searchMap);
		ModelAndView mav = new ModelAndView("detailClub");
		return mav;
	}

}
