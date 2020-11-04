package project.club.p003.service;

import java.util.List;
import java.util.Map;

import project.club.vo.ClubArticleImgVO;
import project.club.vo.ClubArticleVO;


public interface ClubP003_d001Service {
	public void deleteClubArticle(Map<String, Object> searchMap);
	public String writeArticle(Map<String, Object> insertMap);
	public ClubArticleVO editArticle(Map<String, Object> searchMap);
	public List<ClubArticleImgVO> editArticleImg(Map<String, Object> searchMap);
	public void deleteClubArticleImg(Map<String, Object> deleteMap);
	public void updateArticle(Map<String, Object> updateMap);
	public String nextCa_id();
	public void updatePin(Map<String, Object> updateMap);
}
