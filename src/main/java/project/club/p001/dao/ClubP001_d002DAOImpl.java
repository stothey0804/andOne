package project.club.p001.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.club.vo.ClubP001_d001articleVO;

@Repository
public class ClubP001_d002DAOImpl implements ClubP001_d002DAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void deleteClubArticle(Map<String, Object> searchMap) {
		sqlSession.delete("club.p001.deleteClubArticle",searchMap);
	}

	@Override
	public void insertClubArticle(Map<String, Object> insertMap) {
		sqlSession.insert("club.p001.insertClubArticle", insertMap);
	}

	@Override
	public ClubP001_d001articleVO editClubArticle(Map<String, Object> searchMap) {
		ClubP001_d001articleVO articleVO = sqlSession.selectOne("club.p001.editArticleView", searchMap);
		return articleVO;
	}
	
}
