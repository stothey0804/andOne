package project.shop.p003.dao;

import java.util.List;
import java.util.Map;

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

	@Override
	public void updateShopReview(ShopP003ShopReviewVO vo) {
		sqlSession.update("shop.p003.updateShopReview",vo);
	}

	@Override
	public void deleteShopReviewImage(ShopP003ShopReviewImageVO vo) {
		sqlSession.delete("shop.p003.deleteShopReviewImage",vo);
	}

	@Override
	public boolean isDuplicate(ShopP003ShopReviewImageVO vo) {
		boolean result = true;
		if(sqlSession.selectOne("shop.p002.getShopReviewImage",vo)==null) {
			result = false;
		}
		return result;
	}

	@Override
	public void updateShopReviewImage(ShopP003ShopReviewImageVO vo) {
		sqlSession.update("shop.p003.updateShopReviewImage",vo);
	}

	@Override
	public int selectShopReviewListCnt(Map<String,String> searchParam) {
		return sqlSession.selectOne("shop.p003.selectShopReviewListCnt",searchParam);
	}

	@Override
	public List<ShopP003ShopReviewVO> getShopReviewListByPaging(Map<String, String> searchParam) {
		return sqlSession.selectList("shop.p002.getShopReviewListByPaging",searchParam);
	}
}
