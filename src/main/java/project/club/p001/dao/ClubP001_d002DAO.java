package project.club.p001.dao;

import java.util.Map;

import project.club.vo.ClubP001_d001articleVO;

public interface ClubP001_d002DAO {
	public void deleteClubArticle(Map<String, Object> searchMap);
	public void insertClubArticle(Map<String, Object> insertMap);
	public ClubP001_d001articleVO editClubArticle(Map<String, Object> searchMap);
	
}
