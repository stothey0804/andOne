package project.and.p002.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AndP002_d001DAOImpl implements AndP002_d001DAO {
	@Autowired
	private SqlSession sqlSession;

}
