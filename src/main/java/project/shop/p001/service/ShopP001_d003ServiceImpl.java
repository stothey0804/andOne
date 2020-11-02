package project.shop.p001.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p001.dao.ShopP001_d003DAO;
import project.shop.p001.vo.ShopP001BmemberVO;

@Service
public class ShopP001_d003ServiceImpl implements ShopP001_d003Service {
	@Autowired
	private ShopP001_d003DAO shopP001_d003DAO;
	
	@Override
	public String get_findId(ShopP001BmemberVO vo) {
		System.out.println(">>>>>>find2");
		String result = shopP001_d003DAO.findId(vo);
		return result;
	}

	@Override
	public String selectOverlapEmail(String email) {
		return shopP001_d003DAO.selectOverlapEmail(email);
	}

	@Override
	public Map<String, String> selectIdPwdByEmail(String bm_email) {
		return shopP001_d003DAO.selectIdPwdByEmail(bm_email);
	}

	@Override
	public void updatePwd(Map<String, String> paramMap) {
		shopP001_d003DAO.updatePwd(paramMap);
	}

}
