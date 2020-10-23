package project.shop.p001.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;

@Repository
public class ShopP001_d006DAOImpl implements ShopP001_d006DAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String searchOverlapShopId(String shopId) {
		return sqlSession.selectOne("shop.p001.selectOverlapShopId",shopId);
	}

	@Override
	public String searchOverlapShopPhone(String phone) {
		return sqlSession.selectOne("shop.p001.selectOverlapShopPhone",phone);
	}

	@Override
	public void insertShop(ShopP002ShopDetailVO vo) {
		sqlSession.insert("shop.p001.insertShop",vo);
	}

	@Override
	public void insertShopImage(ShopP002ShopImageVO vo) {
		sqlSession.insert("shop.p001.insertShopImage",vo);
		
	}

}
