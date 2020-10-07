package project.club.p001.service;

import java.util.Map;

import project.club.vo.ClubP001_d001articleVO;


public interface ClubP001_d002Service {
	public void deleteClubArticle(Map<String, Object> searchMap);
	public void writeArticle(Map<String, Object> insertMap);
	public ClubP001_d001articleVO editArticle(Map<String, Object> searchMap);
}
