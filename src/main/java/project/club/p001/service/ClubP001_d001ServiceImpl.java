package project.club.p001.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import project.club.p001.dao.ClubP001_d001DAO;
import project.club.vo.ClubMemberVO;
import project.club.vo.ClubVO;

@Service
@Transactional(propagation = Propagation.REQUIRED)
public class ClubP001_d001ServiceImpl implements ClubP001_d001Service{
	@Autowired
	private ClubP001_d001DAO clubP001_d001DAO;

	@Override
	public List<ClubVO> clubList() throws DataAccessException {
		List<ClubVO> clubList = clubP001_d001DAO.clubList();
		return clubList;
	}

	@Override
	public List<ClubVO> myClubList(String m_id) {
		List<ClubVO> myClubList = clubP001_d001DAO.myClubList(m_id);
		return myClubList;
	}
	@Override
	public List<ClubVO> searchClubList(Map<String, Object> searchMap){
		List<ClubVO> searchClubList = clubP001_d001DAO.searchClubList(searchMap);
		return searchClubList;
	}

	@Override
	public ClubVO detailClub(Map<String, Object> searchMap) {
		ClubVO vo = clubP001_d001DAO.detailClub(searchMap);
		return vo;
	}

	@Override
	public String memberCheck(Map<String, Object> searchMap) {
		return clubP001_d001DAO.memberCheck(searchMap);
	}

	@Override
	public List<ClubMemberVO> getLeaderMember(Map<String, Object> searchMap) {
		return clubP001_d001DAO.getLeaderMember(searchMap);
	}

	@Override
	public List<ClubMemberVO> getClubMember(Map<String, Object> searchMap) {
		return clubP001_d001DAO.getClubMember(searchMap);
	}

	@Override
	public List<ClubVO> categoryClubList(Map<String, Object> searchMap) {
		List<ClubVO> categoryClubList = clubP001_d001DAO.categoryClubList(searchMap);
		return categoryClubList;
	}

	@Override
	public String categoryName(Map<String, Object> searchMap) {
		return clubP001_d001DAO.categoryName(searchMap);
	}

	@Override
	public ClubVO detailClubCard(Map<String, Object> searchMap) {
		ClubVO vo = clubP001_d001DAO.detailClubCard(searchMap);
		return vo;
	}
	
}
