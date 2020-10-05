package project.club.p001.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import project.club.p001.dao.ClubP001_d002DAO;
import project.club.vo.ClubP001_d001articleVO;


@Service
@Transactional(propagation = Propagation.REQUIRED)
public class ClubP001_d002ServiceImpl implements ClubP001_d002Service{
	@Autowired
	private ClubP001_d002DAO clubP001_d002DAO;

	@Override
	public void deleteClubArticle(Map<String, Object> searchMap) {
		clubP001_d002DAO.deleteClubArticle(searchMap);
	}

	@Override
	public void writeArticle(Map<String, Object> insertMap) {
		clubP001_d002DAO.insertClubArticle(insertMap);
	}

	@Override
	public ClubP001_d001articleVO editArticle(Map<String, Object> searchMap) {
		ClubP001_d001articleVO articleVO = clubP001_d002DAO.editClubArticle(searchMap);
		return articleVO;
	}

	
}
