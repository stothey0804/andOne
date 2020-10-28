package project.point.p001.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PointP001_d003DAOImpl implements PointP001_d003DAO {
	@Autowired
	private SqlSession sqlSession;
	
	//참가자 신청
	@Override
	public void addOneMember(Map<String, Object> addMemMap) {
		sqlSession.selectList("point.p001.insertOneMember",addMemMap);
	}

}
