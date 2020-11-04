package project.club.p002.dao;

import java.util.Map;

import project.club.vo.ClubVO;

public interface ClubP002_d001DAO {
	public void mergeClub(Map<String, Object> insertMap);
	public String nextC_id();
	public void insertLeader(Map<String, Object> insertMap);
	public void deleteClub(Map<String, Object> searchMap);
	public void updateClub(Map<String, Object> insertMap);
	public void inserClub(Map<String, Object> insertMap);
	public ClubVO detailClub_forUpdate(Map<String, Object> searchMap);
}
