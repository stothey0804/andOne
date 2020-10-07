package project.club.p003.service;

import java.util.Map;

import project.club.vo.ClubArticleVO;


public interface ClubP003_d001Service {
	public void deleteClubArticle(Map<String, Object> searchMap);
	public void writeArticle(Map<String, Object> insertMap);
	public ClubArticleVO editArticle(Map<String, Object> searchMap);
}
