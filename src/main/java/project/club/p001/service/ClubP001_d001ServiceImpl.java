package project.club.p001.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import project.club.p001.dao.ClubP001_d001DAO;
import project.club.vo.ClubP001_d001VO;

@Service
@Transactional(propagation = Propagation.REQUIRED)
public class ClubP001_d001ServiceImpl implements ClubP001_d001Service{
	@Autowired
	private ClubP001_d001DAO clubP001_d001DAO;

	@Override
	public List<ClubP001_d001VO> clubList() throws DataAccessException {
		List<ClubP001_d001VO> clubList = clubP001_d001DAO.clubList();
		return clubList;
	}

	@Override
	public List<ClubP001_d001VO> myClubList(String m_id) {
		List<ClubP001_d001VO> myClubList = clubP001_d001DAO.myClubList(m_id);
		return myClubList;
	}
	@Override
	public List<ClubP001_d001VO> searchClubList(Map<String, Object> searchMap){
		List<ClubP001_d001VO> searchClubList = clubP001_d001DAO.searchClubList(searchMap);
		return searchClubList;
	}

	@Override
	public ClubP001_d001VO detailClub(Map<String, Object> searchMap) {
		ClubP001_d001VO vo = clubP001_d001DAO.detailClub(searchMap);
		return vo;
	}

//	@Override
//	public List<Object> getByteImage(String c_id) {
//		return clubP001_d001DAO.getByteImage(c_id);
//	}

	@Override
	public String memberCheck(Map<String, Object> searchMap) {
		return clubP001_d001DAO.memberCheck(searchMap);
	}
	
}
