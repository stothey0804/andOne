package project.club.p003.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import project.club.p003.dao.ClubP003_d001DAO;
import project.club.vo.ClubArticleImgVO;
import project.club.vo.ClubArticleVO;


@Service
@Transactional(propagation = Propagation.REQUIRED)
public class ClubP003_d001ServiceImpl implements ClubP003_d001Service{
	@Autowired
	private ClubP003_d001DAO clubP003_d001DAO;

	@Override
	public void deleteClubArticle(Map<String, Object> searchMap) {
		clubP003_d001DAO.deleteClubArticle(searchMap);
	}

	@Override
	public String writeArticle(Map<String, Object> insertMap) {
		return clubP003_d001DAO.insertClubArticle(insertMap);
	}

	@Override
	public ClubArticleVO editArticle(Map<String, Object> searchMap) {
		ClubArticleVO articleVO = clubP003_d001DAO.editClubArticle(searchMap);
		return articleVO;
	}

	@Override
	public List<ClubArticleImgVO> editArticleImg(Map<String, Object> searchMap) {
		List<ClubArticleImgVO> list = clubP003_d001DAO.editClubArticleImg(searchMap);
		return list;
	}

	@Override
	public void deleteClubArticleImg(Map<String, Object> deleteMap) {
		clubP003_d001DAO.deleteClubArticleImg(deleteMap);
	}

	@Override
	public void updateArticle(Map<String, Object> updateMap) {
		clubP003_d001DAO.updateClubArticle(updateMap);
	}

	@Override
	public String nextCa_id() {
		return clubP003_d001DAO.nextCa_id();
	}

	@Override
	public void updatePin(Map<String, Object> updateMap) {
		clubP003_d001DAO.updatePin(updateMap);
	}
	
}
