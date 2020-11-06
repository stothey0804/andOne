package project.club.p001.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import project.club.p001.dao.ClubP001_d002DAO;
import project.club.vo.ClubVO;

@Service
@Transactional(propagation = Propagation.REQUIRED)
public class ClubP001_d002ServiceImpl implements ClubP001_d002Service{
	@Autowired
	private ClubP001_d002DAO clubP001_d002DAO;

	@Override
	public List<ClubVO> clubList(Map<String, Object> searchMap) {
		List<ClubVO> clubList = clubP001_d002DAO.clubList(searchMap);
		return clubList;
	}

	@Override
	public int clubCnt(Map<String, Object> searchMap) {
		return clubP001_d002DAO.clubCnt(searchMap);
	}

}
