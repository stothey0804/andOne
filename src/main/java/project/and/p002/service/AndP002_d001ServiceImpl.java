package project.and.p002.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import project.and.p002.dao.AndP002_d001DAO;

@Service
public class AndP002_d001ServiceImpl implements AndP002_d001Service {
	@Autowired
	private AndP002_d001DAO p002_d001DAO;
	
	//글쓰기
	@Override
	public void insertAndOne(Map<String,Object> Andone) throws DataAccessException {
		System.out.println(">>>>>>"+Andone.get("one_locate_Lat"));
		System.out.println(">>>>>>"+Andone.get("one_locate_Lng"));
		p002_d001DAO.insertAndOne(Andone);	
	}
	//one_member 테이블 변경
	@Override
	public void insertOneMem(Map<String,Object> Andone) throws DataAccessException {
		p002_d001DAO.insertOneMem(Andone);
	}
	//삭제하기
	@Override
	public void deleteAndOne(String one_id) {
		p002_d001DAO.deleteAndOne(one_id);
	}
	//멤버 수 구하기
	@Override
	public int countOneMem(String one_id) {
		int count = p002_d001DAO.countOneMem(one_id);
		return count;
	}
	//완료하기
	@Override
	public void completeAndOne(Map<String, Object> completeMap) {
		p002_d001DAO.completeAndOne(completeMap);
	}
	
	

}
