package project.and.p002.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

public interface AndP002_d001Service {
	public List<Map> insertAndOne(Map<String,String> Andone) throws DataAccessException;

}
