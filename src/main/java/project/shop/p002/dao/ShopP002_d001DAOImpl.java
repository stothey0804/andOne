package project.shop.p002.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Repository
public class ShopP002_d001DAOImpl implements ShopP002_d001DAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ShopP002ShopDetailVO> getShopList(ShopP002ShopDetailVO vo) {
		return sqlSession.selectList("shop.p002.getShopShort",vo);
	}

	@Override
	public ShopP002ShopDetailVO getShopDetail(ShopP002ShopDetailVO vo) {
		return sqlSession.selectOne("shop.p002.getShopDetail",vo);
	}
	
	@Override
	public ShopP003ShopReviewVO getShopReview(ShopP003ShopReviewVO vo) {
		return sqlSession.selectOne("shop.p002.getShopReview",vo);
	}

	@Override
	public void updateShopImage(ShopP002ShopImageVO vo) {
		sqlSession.update("shop.p002.updateShopImage",vo);
	}

	@Override
	public Map<String, Object> getShopImage() {
		return sqlSession.selectOne("shop.p002.getShopImage");
	}

	@Override
	public void updateShopReviewImage(ShopP003ShopReviewImageVO vo) {
		sqlSession.update("shop.p002.updateShopReviewImage",vo);
	}

	@Override
	public List<String> getAllHashtag() {
		return sqlSession.selectList("shop.p002.getAllHashtag");
	}

	@Override
	public void updatePopularHashtag(String result) {
		sqlSession.update("shop.p002.updatePopularHashtag", result);
	}

	@Override
	public String getPopularHashtag() {
		return sqlSession.selectOne("shop.p002.getPopularHashtag");
	}

}
