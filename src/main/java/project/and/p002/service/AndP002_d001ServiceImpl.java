package project.and.p002.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import project.and.p002.dao.AndP002_d001DAO;

@Service
public class AndP002_d001ServiceImpl implements AndP002_d001Service {
	@Autowired
	private AndP002_d001DAO p002_d001DAO;
	
	public List<Map<String, Object>> insertAndOne(Map<String,Object> Andone) throws DataAccessException {
		System.out.println(">>>>>>"+Andone.get("one_locate_Lat"));
		System.out.println(">>>>>>"+Andone.get("one_locate_Lng"));
		List<Map<String, Object>> insertAndOne = p002_d001DAO.insertAndOne(Andone);
		return insertAndOne;	
	}
	public void insertOneMem(Map<String,Object> Andone) throws DataAccessException {
		List<Map<String, Object>> insertOneMem = p002_d001DAO.insertOneMem(Andone);
	}
	@Override
	public void deleteAndOne(String one_id) {
		p002_d001DAO.deleteAndOne(one_id);
	}
	@Override
	public int countOneMem(String one_id) {
		int count = p002_d001DAO.countOneMem(one_id);
		return count;
	}
	
	@Override
	public void editAndOne(String one_id) {
		p002_d001DAO.editAndOne(one_id);
		
	}
	

}
