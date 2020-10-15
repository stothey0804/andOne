package project.shop.p001.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.shop.p001.vo.ShopP001BmemberVO;

@Repository
public class ShopP001_d002DAOImpl implements ShopP001_d002DAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ShopP001BmemberVO loginCheck(String id) {
		System.out.println(">>>>>>loginDAO");
		ShopP001BmemberVO bMember = sqlSession.selectOne("shop.p001.loginCheck", id);
		return bMember;
	}

}
