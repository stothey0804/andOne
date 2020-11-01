package project.club.p003.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import project.club.p003.dao.ClubP003_d003DAO;


@Service
@Transactional(propagation = Propagation.REQUIRED)
public class ClubP003_d003ServiceImpl implements ClubP003_d003Service{
	@Autowired
	private ClubP003_d003DAO clubP003_d003DAO;

	@Override
	public void insertReply(Map<String, Object> insertMap) {
		clubP003_d003DAO.insertReply(insertMap);
	}

	@Override
	public void deleteReply(Map<String, Object> deleteMap) {
		clubP003_d003DAO.deleteReply(deleteMap);
	}

	@Override
	public void updateReply(Map<String, Object> updateMap) {
		clubP003_d003DAO.updateReply(updateMap);
	}

}
