package project.club.p001.dao;

import java.util.List;
import java.util.Map;

import project.club.vo.ClubVO;

public interface ClubP001_d001DAO {
	public List<ClubVO> clubList();
	public List<ClubVO> myClubList(String m_id);
	public List<ClubVO> searchClubList(Map<String, Object> searchMap);
	public ClubVO detailClub(Map<String, Object> searchMap);
//	public List<Object> getByteImage(String c_id);
	public String memberCheck(Map<String, Object> searchMap);
}
