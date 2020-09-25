package project.shop.p002.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.shop.p002.vo.P002ShopDetailVO;

@Repository
public class P002_d001DAOImpl implements P002_d001DAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public P002ShopDetailVO getShopDetail(P002ShopDetailVO vo) {
		return sqlSession.selectOne("shop.p002.getShopDetail",vo);
	}

	@Override
	public List<P002ShopDetailVO> getShopList(P002ShopDetailVO vo) {
		return sqlSession.selectList("shop.p002.getShopList",vo);
	}

}
