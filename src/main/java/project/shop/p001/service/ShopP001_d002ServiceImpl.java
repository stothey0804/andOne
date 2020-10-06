package project.shop.p001.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p001.dao.ShopP001_d002DAO;
import project.shop.p001.vo.ShopP001BmemberVO;

@Service
public class ShopP001_d002ServiceImpl implements ShopP001_d002Service {
	@Autowired
	private ShopP001_d002DAO shopP001_d002DAO;
	
	@Override
	public ShopP001BmemberVO loginCheck(String id) {
		System.out.println(">>>>>>loginService");
		return shopP001_d002DAO.loginCheck(id);
	}
}