package project.club.p001.service;

import java.util.List;
import java.util.Map;

import project.club.vo.ClubMemberVO;
import project.club.vo.ClubVO;


public interface ClubP001_d001Service {
	public List<ClubVO> clubList();
	public List<ClubVO> myClubList(String m_id);
	public List<ClubVO> searchClubList(Map<String, Object> searchMap);
	public ClubVO detailClub(Map<String, Object> searchMap);
	public String memberCheck(Map<String, Object> searchMap);
	public List<ClubMemberVO> getLeaderMember(Map<String, Object> searchMap);
	public List<ClubMemberVO> getClubMember(Map<String, Object> searchMap);
}
