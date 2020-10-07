package project.club.p002.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ClubP002_d001DAOImpl implements ClubP002_d001DAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertClub(Map<String, Object> insertMap) {
		sqlSession.insert("club.p002.insertClub",insertMap);
	}
	
	@Override
	public String nextC_id() {
		return sqlSession.selectOne("club.p002.nextC_id");
	}

	@Override
	public void insertLeader(Map<String, Object> insertMap) {
		sqlSession.insert("club.p002.insertLeader", insertMap);
	}

}
