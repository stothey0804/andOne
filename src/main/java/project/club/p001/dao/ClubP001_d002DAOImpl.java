package project.club.p001.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class ClubP001_d002DAOImpl implements ClubP001_d002DAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void deleteClubArticle(Map<String, Object> searchMap) {
		sqlSession.delete("club.p001.deleteClubArticle");
	}
	
}
