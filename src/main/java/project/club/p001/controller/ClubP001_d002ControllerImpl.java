package project.club.p001.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import project.club.p001.dao.ClubP001_d002DAO;
import project.club.p001.service.ClubP001_d001Service;
import project.club.p001.service.ClubP001_d002Service;
import project.club.p001.vo.ClubP001_d001VO;
import project.club.p001.vo.ClubP001_d001articleVO;

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
	@RequestMapping(value="/createClub.do",method= {RequestMethod.GET})
	public ModelAndView createClub() throws Exception {
		ModelAndView mav = new ModelAndView("createClub");
		return mav;
	}
	
	@Override
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
	@RequestMapping(value="/writeArticle.do", method= {RequestMethod.GET})
	public ModelAndView writeArticle(@RequestParam HashMap<String, Object> paramMap) throws Exception{
		try {
			MultipartFile articleFile = (MultipartFile) paramMap.get("file");
			Map<String, Object> insertMap = new HashMap<String, Object>();
			insertMap.put("ca_img", articleFile.getBytes());
			insertMap.put("ca_content", paramMap.get("content"));
			insertMap.put("m_id", paramMap.get("m_id"));
			insertMap.put("c_id", paramMap.get("c_id"));
			clubP001_d002Service.writeArticle(insertMap);
		} catch(Exception e) {
			e.printStackTrace();
		}
		ModelAndView mav = new ModelAndView("result");
		return mav;
	}

}
