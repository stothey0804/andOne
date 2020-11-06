package project.club.p001.controller;

import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import project.club.vo.ClubVO;

public interface ClubP001_d002Controller {
	public ModelAndView searchClubListAdmin(int curPage, ClubVO clubVO, Map<String, Object> searchMap);
}
