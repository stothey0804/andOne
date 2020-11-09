package project.club.p001.dao;

import java.util.List;
import java.util.Map;

import project.and.vo.AndP002AndOneVO;
import project.club.vo.ClubMemberVO;
import project.club.vo.ClubVO;

public interface ClubP001_d001DAO {
	public List<ClubVO> clubList();
	public List<ClubVO> myClubList(String m_id);
	public List<ClubVO> searchClubList(Map<String, Object> searchMap);
	public ClubVO detailClub(Map<String, Object> searchMap);
	public String memberCheck(Map<String, Object> searchMap);
	public List<ClubMemberVO> getClubMember(Map<String, Object> searchMap);
	public List<ClubMemberVO> getLeaderMember(Map<String, Object> searchMap);
	public List<ClubVO> categoryClubList(Map<String, Object> searchMap);
	public String categoryName(Map<String, Object> searchMap);
	public ClubVO detailClubCard(Map<String, Object> searchMap);
	public List<ClubVO> searchClubListHashtag(Map<String, Object> searchMap);
	public int searchClubListCnt(Map<String, Object> searchMap);
	public int searchClubListCntHashtag(Map<String, Object> searchMap);
	public int searchClubListCntCategory(Map<String, Object> searchMap);
	public List<AndP002AndOneVO> getAndOne(Map<String, Object> searchMap);
}
