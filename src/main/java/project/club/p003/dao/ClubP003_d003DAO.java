package project.club.p003.dao;

import java.util.Map;

public interface ClubP003_d003DAO {
	public void insertReply(Map<String, Object> insertMap);
	public void deleteReply(Map<String, Object> deleteMap);
	public void updateReply(Map<String, Object> updateMap);
	public String next_car_id();
}
