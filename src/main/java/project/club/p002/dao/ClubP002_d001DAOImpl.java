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
	public void mergeClub(Map<String, Object> insertMap) {
		sqlSession.insert("club.p002.mergeClub",insertMap);
	}
	
	@Override
	public String nextC_id() {
		return sqlSession.selectOne("club.p002.nextC_id");
	}

	@Override
	public void insertLeader(Map<String, Object> insertMap) {
		sqlSession.insert("club.p002.insertLeader", insertMap);
	}

	@Override
	public void deleteClub(Map<String, Object> searchMap) {
		sqlSession.delete("club.p002.deleteClub",searchMap);
	}

	@Override
	public void updateClub(Map<String, Object> insertMap) {
		sqlSession.update("club.p002.updateClub",insertMap);
	}

	@Override
	public void inserClub(Map<String, Object> insertMap) {
		sqlSession.insert("club.p002.insertClub", insertMap);
	}

}
