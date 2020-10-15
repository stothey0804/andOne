package project.shop.p001.dao;


import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import project.shop.p001.vo.ShopP001BmemberVO;

@Repository
public class ShopP001_d001DAOImpl implements ShopP001_d001DAO {
	@Autowired
	private SqlSession sqlSession;
	
	///아이디 중복체크
	@Override
	public int checkId(String bm_id) throws DataAccessException{
		System.out.println(">>>>>>>>>>>dao");
		int result = sqlSession.selectOne("shop.p001.checkId",bm_id);
		System.out.println(result);
		return result;
	}
	//이메일 중복체크
	@Override
	public int checkEmail(String bm_email) throws DataAccessException{
		System.out.println(">>>>>>>>>>>dao");
		int result = sqlSession.selectOne("shop.p001.checkEmail",bm_email);
		System.out.println(result);
		return result;
	}
	//회원가입
	@Override
	public int insertBmember(ShopP001BmemberVO vo) throws DataAccessException {
		System.out.println(">>>>>>>>>>> 회원가입dao");
		int result = sqlSession.insert("shop.p001.insertBmember", vo); // 회원가입 성공하면 1반환
		return result;
	}

}
