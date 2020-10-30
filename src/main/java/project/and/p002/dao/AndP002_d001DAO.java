package project.and.p002.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

public interface AndP002_d001DAO {
	public List<Map<String,Object>> insertAndOne(Map<String,Object> Andone) throws DataAccessException;
	public List<Map<String, Object>> insertOneMem(Map<String, Object> andone);
	public void deleteAndOne(String one_id);

}
