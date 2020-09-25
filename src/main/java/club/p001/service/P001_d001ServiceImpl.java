package club.p001.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import club.p001.dao.P001_d001DAO;
import club.p001.vo.P001_d001VO;

@Service("club")
@Transactional(propagation = Propagation.REQUIRED)
public class P001_d001ServiceImpl implements P001_d001Service{
	@Autowired
	private P001_d001DAO p001_d001DAO;

	@Override
	public List<P001_d001VO> clubList() throws DataAccessException {
		List<P001_d001VO> clubList = p001_d001DAO.clubList();
		return clubList;
	}

	@Override
	public List<P001_d001VO> myClubList() {
		List<P001_d001VO> myClubList = p001_d001DAO.myClubList();
		return myClubList;
	}
	
	@Override
	public List<P001_d001VO> searchClubList(Map<String, Object> searchMap){
		List<P001_d001VO> searchClubList = p001_d001DAO.searchClubList(searchMap);
		return searchClubList;
	}

	@Override
	public P001_d001VO detailClub(Map<String, Object> searchMap) {
		P001_d001VO vo = p001_d001DAO.detailClub(searchMap);
		return vo;
	}
	
}
