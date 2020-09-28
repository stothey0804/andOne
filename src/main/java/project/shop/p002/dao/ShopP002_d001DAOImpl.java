package project.shop.p002.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.shop.p002.vo.ShopP002ShopDetailVO;

@Repository
public class ShopP002_d001DAOImpl implements ShopP002_d001DAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ShopP002ShopDetailVO> getShopList(ShopP002ShopDetailVO vo) {
		return sqlSession.selectList("shop.p002.getShopList",vo);
	}

}
