package project.shop.p001.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import project.shop.p001.dao.ShopP001_d001DAO;
import project.shop.p001.vo.ShopP001BmemberVO;

@Service
public class ShopP001_d001ServiceImpl implements ShopP001_d001Service{
	@Autowired
	private ShopP001_d001DAO shopP001_d001DAO;
	
	@Override
	public int IdCheck(String bm_id) throws DataAccessException {
		System.out.println(">>>>>>아이디 중복체크 Service");
		int result = shopP001_d001DAO.checkId(bm_id);
		System.out.println(result);
		return result;
	}
	@Override
	public int EmailCheck(String bm_email) throws DataAccessException {
		System.out.println(">>>>>>이메일 중복체크 Service");
		int result = shopP001_d001DAO.checkEmail(bm_email);
		System.out.println(result);
		return result;
	}
	@Override
	public int addBmember(ShopP001BmemberVO vo) throws DataAccessException{
		System.out.println(">>>>>>회원가입 Service");
		int result = shopP001_d001DAO.insertBmember(vo);
		return result;
	}
	

}
