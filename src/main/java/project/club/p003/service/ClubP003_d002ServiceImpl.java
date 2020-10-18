package project.club.p003.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import project.club.p003.dao.ClubP003_d002DAO;


@Service
@Transactional(propagation = Propagation.REQUIRED)
public class ClubP003_d002ServiceImpl implements ClubP003_d002Service{
	@Autowired
	private ClubP003_d002DAO clubP003_d002DAO;

	@Override
	public void joinClub(Map<String, Object> insertMap) {
		clubP003_d002DAO.joinClub(insertMap);
	}

	@Override
	public void leaveClub(Map<String, Object> deleteMap) {
		clubP003_d002DAO.leaveClub(deleteMap);
	}

	@Override
	public void reportClub(Map<String, Object> insertMap) {
		clubP003_d002DAO.reportClub(insertMap);
	}
}
