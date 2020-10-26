package project.club.p002.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.club.p002.dao.ClubP002_d001DAO;

@Service
public class ClubP002_d001ServiceImpl implements ClubP002_d001Service{
	@Autowired
	private ClubP002_d001DAO clubP002_d001DAO;

	@Override
	public void mergeClub(Map<String, Object> insertMap) {
		clubP002_d001DAO.mergeClub(insertMap);
	}

	@Override
	public String nextC_id() {
		return clubP002_d001DAO.nextC_id();
	}

	@Override
	public void insertLeader(Map<String, Object> insertMap) {
		clubP002_d001DAO.insertLeader(insertMap);
	}

	@Override
	public void deleteClub(Map<String, Object> searchMap) {
		clubP002_d001DAO.deleteClub(searchMap);
	}

	@Override
	public void updateClub(Map<String, Object> insertMap) {
		clubP002_d001DAO.updateClub(insertMap);
	}
	
}
