package project.club.p003.dao;

import java.util.List;
import java.util.Map;

import project.club.vo.ClubArticleImgVO;
import project.club.vo.ClubArticleVO;

public interface ClubP003_d001DAO {
	public void deleteClubArticle(Map<String, Object> searchMap);
	public String insertClubArticle(Map<String, Object> insertMap);
	public ClubArticleVO editClubArticle(Map<String, Object> searchMap);
	public void insertClubArticleImg(Map<String, Object> insertMap);
	public List<ClubArticleImgVO> editClubArticleImg(Map<String, Object> searchMap);
	public void deleteClubArticleImg(Map<String, Object> deleteMap);
	public void updateClubArticle(Map<String, Object> updateMap);
	public void updateClubArticleImg(Map<String, Object> updateMap);
	public String nextCa_id();
}
