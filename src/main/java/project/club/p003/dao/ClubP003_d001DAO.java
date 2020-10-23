package project.club.p003.dao;

import java.util.Map;

import project.club.vo.ClubArticleVO;

public interface ClubP003_d001DAO {
	public void deleteClubArticle(Map<String, Object> searchMap);
	public void insertClubArticle(Map<String, Object> insertMap);
	public ClubArticleVO editClubArticle(Map<String, Object> searchMap);
	void insertClubArticleImg(Map<String, Object> insertMap);
}
