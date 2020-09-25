package project.club.p001.service;

import java.util.List;
import java.util.Map;

import project.club.p001.vo.ClubP001_d001VO;

public interface ClubP001_d001Service {
	public List<ClubP001_d001VO> clubList();
	public List<ClubP001_d001VO> myClubList();
	public List<ClubP001_d001VO> searchClubList(Map<String, Object> searchMap);
	public ClubP001_d001VO detailClub(Map<String, Object> searchMap);
}
