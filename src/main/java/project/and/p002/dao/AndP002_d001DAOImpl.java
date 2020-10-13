package project.and.p002.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository
public class AndP002_d001DAOImpl implements AndP002_d001DAO {
	@Autowired
	private SqlSession sqlSession;
	
	public List<Map> insertAndOne(Map<String,String> Andone) throws DataAccessException{
		List<Map> insertAndOne = sqlSession.selectList("and.p002.insertAndOne",Andone);
		return insertAndOne;
	}

}
