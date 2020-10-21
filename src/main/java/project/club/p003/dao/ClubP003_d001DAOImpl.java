package project.club.p003.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.club.vo.ClubArticleVO;

@Repository
public class ClubP003_d001DAOImpl implements ClubP003_d001DAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void deleteClubArticle(Map<String, Object> searchMap) {
		sqlSession.delete("club.p003.deleteClubArticle",searchMap);
	}

	@Override
	public void insertClubArticle(Map<String, Object> insertMap) {
		sqlSession.insert("club.p003.insertClubArticle", insertMap);
		System.out.println("들어와봐");
	}

	@Override
	public void insertClubArticleImg(Map<String, Object> insertMap) {
		sqlSession.insert("club.p003.insertClubArticleImg", insertMap);
		System.out.println("zz22");
	}

	@Override
	public ClubArticleVO editClubArticle(Map<String, Object> searchMap) {
		ClubArticleVO articleVO = sqlSession.selectOne("club.p003.editArticleView", searchMap);
		return articleVO;
	}
}
