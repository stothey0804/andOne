package project.and.p002.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository
public class AndP002_d001DAOImpl implements AndP002_d001DAO {
	@Autowired
	private SqlSession sqlSession;
	
	public void insertAndOne(Map<String,Object> Andone) throws DataAccessException{
		System.out.println(">>>>>>"+Andone.get("one_locate_Lat"));
		System.out.println(">>>>>>"+Andone.get("one_locate_Lng"));
		sqlSession.insert("and.p002.insertAndOne",Andone);
	}
	public void insertOneMem(Map<String,Object> Andone) throws DataAccessException{
		System.out.println(">>>>>>"+Andone.get("one_locate_Lat"));
		System.out.println(">>>>>>"+Andone.get("one_locate_Lng"));
		sqlSession.insert("and.p002.insertOneMem",Andone);
	}
	@Override
	public void deleteAndOne(String one_id) {
		sqlSession.delete("and.p002.deleteAndOne",one_id);
	}
	@Override
	public int countOneMem(String one_id) {
		int countOneMem = sqlSession.selectOne("and.p002.selectCntOneMem", one_id);
		return countOneMem;
	}
	@Override
	public void editAndOne(String one_id) {
		sqlSession.update("and.p002.insertAndOne", one_id);
	}
	@Override
	public void completeAndOne(Map<String, Object> completeMap) {
		sqlSession.update("and.p002.updateCompleteAndOne", completeMap);
	}
	

}
