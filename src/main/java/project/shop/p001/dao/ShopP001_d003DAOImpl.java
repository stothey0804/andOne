package project.shop.p001.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.shop.p001.vo.ShopP001BmemberVO;

@Repository
public class ShopP001_d003DAOImpl implements ShopP001_d003DAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String findId(ShopP001BmemberVO vo) {
		System.out.println(">>>>>>find3");
		String result = sqlSession.selectOne("shop.p001.findId",vo);
		return result;
	}

	@Override
	public String selectOverlapEmail(String email) {
		return sqlSession.selectOne("shop.p001.selectOverlapEmail",email);
	}
}
