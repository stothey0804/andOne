package project.shop.p001.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p001.dao.ShopP001_d005DAO;
import project.shop.p001.vo.ShopP001BmemberVO;

@Service
public class ShopP001_d005ServiceImpl implements ShopP001_d005Service{
	
	@Autowired
	private ShopP001_d005DAO shopP001_d005DAO;
	
	@Override
	public String selectPwdById(String bm_id) {
		return shopP001_d005DAO.selectPwdById(bm_id);
	}

	@Override
	public void updateBmember(ShopP001BmemberVO vo) {
		shopP001_d005DAO.updateBmember(vo);
	}

	@Override
	public String searchOverlapEmail(String email) {
		return shopP001_d005DAO.searchOverlapEmail(email);
	}

	@Override
	public String searchOverlapPhone(String phone) {
		return shopP001_d005DAO.searchOverlapPhone(phone);
	}

	@Override
	public void deleteBmember(String bm_id) {
		shopP001_d005DAO.deleteBmember(bm_id);
	}

	@Override
	public void deleteShop(String s_id) {
		shopP001_d005DAO.deleteShop(s_id);
	}

	@Override
	public String getShopIdByBmemberId(String bm_id) {
		return shopP001_d005DAO.getShopIdByBmemberId(bm_id);
	}

}
