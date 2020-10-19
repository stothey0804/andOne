package project.club.p003.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ClubP003_d002DAOImpl implements ClubP003_d002DAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void joinClub(Map<String, Object> insertMap) {
		sqlSession.insert("club.p003.joinClubMember", insertMap);
	}

	@Override
	public void leaveClub(Map<String, Object> deleteMap) {
		sqlSession.delete("club.p003.leaveClub",deleteMap);
	}

	@Override
	public void reportClub(Map<String, Object> insertMap) {
		sqlSession.insert("club.p003.reportClub",insertMap);
	}
}
