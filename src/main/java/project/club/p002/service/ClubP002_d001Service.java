package project.club.p002.service;

import java.util.Map;

public interface ClubP002_d001Service {
	public void createClub(Map<String, Object> insertMap);
	public String nextC_id();
	public void insertLeader(Map<String, Object> insertMap);
	public void deleteClub(Map<String, Object> searchMap);
}
