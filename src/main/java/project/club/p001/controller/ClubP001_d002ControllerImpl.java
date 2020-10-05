package project.club.p001.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import project.club.p001.dao.ClubP001_d002DAO;
import project.club.p001.service.ClubP001_d001Service;
import project.club.p001.service.ClubP001_d002Service;
import project.club.vo.ClubP001_d001VO;
import project.club.vo.ClubP001_d001articleVO;

@Controller
public class ClubP001_d002ControllerImpl implements ClubP001_d002Controller{
	@Autowired
	ClubP001_d002Service clubP001_d002Service;
	@Autowired
	ClubP001_d001Service clubP001_d001Service;
	@Autowired
	ClubP001_d001articleVO p001_d001;
	@Autowired
	ClubP001_d002DAO clubp001_d002DAO;
	
	@Override
	@ResponseBody
	@RequestMapping(value="/deleteClubArticle.do",method= {RequestMethod.GET})
	public void deleteClubArticle(@RequestParam(value="ca_id",required = false) String ca_id) throws Exception {
		System.out.println(ca_id);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("ca_id", ca_id);
		clubP001_d002Service.deleteClubArticle(searchMap);
	}

	@Override
	@RequestMapping(value="/club/writeArticleForm.do",method= {RequestMethod.GET})
	public ModelAndView writeArticleForm(@RequestParam(value="c_id",required = true) String c_id) throws Exception {
		System.out.println(c_id);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id", c_id);
		ClubP001_d001VO vo = clubP001_d001Service.detailClub(searchMap);
		ModelAndView mav = new ModelAndView("writeArticleForm");
		mav.addObject("clubInfo", vo);
		return mav;
	}
	
	@Override
	@ResponseBody
	@RequestMapping(value="/writeArticle.do", method= {RequestMethod.GET,RequestMethod.POST})
	public void writeArticle(ClubP001_d001articleVO vo, HttpServletRequest request) throws Exception{
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("ca_img", vo.getCa_img().getBytes());
		insertMap.put("ca_content", vo.getCa_content());
		insertMap.put("m_id", vo.getM_id());
		insertMap.put("c_id", vo.getC_id());
		clubP001_d002Service.writeArticle(insertMap);
	}
	
	@Override
	@RequestMapping(value="/editClubArticle.do", method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView editArticle(@RequestParam(value="ca_id", required=true) String ca_id) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("ca_id", ca_id);
		ClubP001_d001articleVO articleVO = clubP001_d002Service.editArticle(searchMap);
		ModelAndView mav = new ModelAndView("editArticle");
		mav.addObject("articleInfo", articleVO);
		return mav;
	}

}
