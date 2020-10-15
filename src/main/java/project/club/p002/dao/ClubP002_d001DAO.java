package project.club.p002.dao;

import java.util.Map;

public interface ClubP002_d001DAO {
	public void insertClub(Map<String, Object> insertMap);
	public String nextC_id();
	public void insertLeader(Map<String, Object> insertMap);
	public void deleteClub(Map<String, Object> searchMap);
}
