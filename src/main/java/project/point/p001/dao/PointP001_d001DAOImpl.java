package project.point.p001.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PointP001_d001DAOImpl implements PointP001_d001DAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public String selectNowPointById(String m_id) {
		return sqlSession.selectOne("point.p001.selectNowPointById", m_id);
	}
	
}
