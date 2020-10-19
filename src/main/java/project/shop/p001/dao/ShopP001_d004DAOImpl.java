package project.shop.p001.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.shop.p001.vo.ShopP001StatisticsVO;

@Repository
public class ShopP001_d004DAOImpl implements ShopP001_d004DAO{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ShopP001StatisticsVO sixMonthScoreStatistics(String s_id) {
		return sqlSession.selectOne("shop.p001.sixMonthScoreStatistics",s_id);
	}

	@Override
	public ShopP001StatisticsVO sixMonthReviewStatistics(String s_id) {
		return sqlSession.selectOne("shop.p001.sixMonthReviewStatistics",s_id);
	}
}
