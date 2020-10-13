package project.and.p002.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

public interface AndP002_d001DAO {
	public List<Map> insertAndOne(Map<String,String> Andone) throws DataAccessException;

}
