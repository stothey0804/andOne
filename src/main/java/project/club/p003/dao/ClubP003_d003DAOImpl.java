package project.club.p003.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ClubP003_d003DAOImpl implements ClubP003_d003DAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertReply(Map<String, Object> insertMap) {
		sqlSession.insert("club.p003_d003.insertReply",insertMap);
	}

	@Override
	public void deleteReply(Map<String, Object> deleteMap) {
		sqlSession.delete("club.p003_d003.deleteReply", deleteMap);
	}

	@Override
	public void updateReply(Map<String, Object> updateMap) {
		sqlSession.update("club.p003_d003.updateReply", updateMap);
	}

	@Override
	public String next_car_id() {
		return sqlSession.selectOne("club.p003_d003.next_car_id");
	}

}
