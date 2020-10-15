package project.shop.p003.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Repository
public class ShopP003_d001DAOImpl implements ShopP003_d001DAO{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public boolean checkShopReview(ShopP003ShopReviewVO vo) {
		boolean result = false;
		if(sqlSession.selectOne("shop.p003.checkShopReview",vo)==null) {
			result = true;
		}
		return result;
	}

	@Override
	public void insertShopReview(ShopP003ShopReviewVO vo) {
		sqlSession.insert("shop.p003.insertShopReview",vo);
	}

	@Override
	public void insertShopReviewImage(ShopP003ShopReviewImageVO vo) {
		sqlSession.insert("shop.p003.insertShopReviewImage",vo);
	}
}
