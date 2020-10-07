package project.shop.p002.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p002.dao.ShopP002_d001DAO;
import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Service
public class ShopP002_d001ServiceImpl implements ShopP002_d001Service {
	
	@Autowired
	private ShopP002_d001DAO shopP002_d001DAO;
	
	@Override
	public List<ShopP002ShopDetailVO> getShopList(ShopP002ShopDetailVO vo) {
		return shopP002_d001DAO.getShopList(vo);
	}

	@Override
	public ShopP002ShopDetailVO getShopDetail(ShopP002ShopDetailVO vo) {
		return shopP002_d001DAO.getShopDetail(vo);
	}

	@Override
	public ShopP003ShopReviewVO getShopReview(ShopP003ShopReviewVO vo) {
		return shopP002_d001DAO.getShopReview(vo);
	}

	@Override
	public void updateShopImage(ShopP002ShopImageVO vo) {
		shopP002_d001DAO.updateShopImage(vo);
	}

	@Override
	public Map<String, Object> getShopImage() {
		return shopP002_d001DAO.getShopImage();
	}

	@Override
	public void updateShopReviewImage(ShopP003ShopReviewImageVO vo) {
		shopP002_d001DAO.updateShopReviewImage(vo);
		
	}

}
