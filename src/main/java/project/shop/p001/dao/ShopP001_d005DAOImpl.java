package project.shop.p001.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.shop.p001.vo.ShopP001BmemberVO;

@Repository
public class ShopP001_d005DAOImpl implements ShopP001_d005DAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectPwdById(String bm_id) {
		return sqlSession.selectOne("shop.p001.selectPwdById",bm_id);
	}

	@Override
	public void updateBmember(ShopP001BmemberVO vo) {
		sqlSession.update("shop.p001.updateBmember",vo);
	}

	@Override
	public String searchOverlapEmail(String email) {
		return sqlSession.selectOne("shop.p001.selectOverlapEmail",email);
	}

	@Override
	public String searchOverlapPhone(String phone) {
		return sqlSession.selectOne("shop.p001.selectOverlapPhone",phone);
	}

	@Override
	public void deleteBmember(String bm_id) {
		sqlSession.delete("shop.p001.deleteBmember",bm_id);
	}

	@Override
	public void deleteShop(String s_id) {
		sqlSession.delete("shop.p001.deleteShop",s_id);
		sqlSession.delete("shop.p001.deleteShopImage",s_id);
		sqlSession.delete("shop.p001.deleteShopReview",s_id);
		sqlSession.delete("shop.p001.deleteShopReviewImage",s_id);
	}
	
	public void deleteShopImage(String s_id) {
		sqlSession.delete("shop.p001.deleteShopImage",s_id);
	}

	@Override
	public String getShopIdByBmemberId(String bm_id) {
		return sqlSession.selectOne("shop.p001.getShopIdByBmemberId",bm_id);
	}

}
