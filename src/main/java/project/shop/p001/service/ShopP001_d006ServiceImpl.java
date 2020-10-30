package project.shop.p001.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p001.dao.ShopP001_d006DAO;
import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;

@Service
public class ShopP001_d006ServiceImpl implements ShopP001_d006Service{
	
	@Autowired
	private ShopP001_d006DAO shopP001_d006DAO;
	
	@Override
	public String searchOverlapShopId(String shopId) {
		return shopP001_d006DAO.searchOverlapShopId(shopId);
	}

	@Override
	public String searchOverlapShopPhone(String phone) {
		return shopP001_d006DAO.searchOverlapShopPhone(phone);
	}

	@Override
	public void insertShop(ShopP002ShopDetailVO vo) {
		shopP001_d006DAO.insertShop(vo);
	}

	@Override
	public void insertShopImage(ShopP002ShopImageVO vo) {
		shopP001_d006DAO.insertShopImage(vo);
	}

	@Override
	public void updateShop(ShopP002ShopDetailVO vo) {
		shopP001_d006DAO.updateShop(vo);
	}

	@Override
	public void updateShopImage(ShopP002ShopImageVO vo) {
		shopP001_d006DAO.updateShopImage(vo);
	}

	@Override
	public Map<String, String> getShopLocateByShopId(String s_id) {
		return shopP001_d006DAO.getShopLocateByShopId(s_id);
	}

	@Override
	public void updateReviewPublicStatus(Map<String, String> param) {
		shopP001_d006DAO.updateReviewPublicStatus(param);
	}

}
