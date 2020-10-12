package project.shop.p003.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p003.dao.ShopP003_d001DAO;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Service
public class ShopP003_d001ServiceImpl implements ShopP003_d001Service{
	
	@Autowired
	private ShopP003_d001DAO shopP003_d001DAO;

	@Override
	public boolean checkShopReview(ShopP003ShopReviewVO vo) {
		return shopP003_d001DAO.checkShopReview(vo);
	}

	@Override
	public void insertShopReview(ShopP003ShopReviewVO vo) {
		shopP003_d001DAO.insertShopReview(vo);
	}

	@Override
	public void insertShopReviewImage(ShopP003ShopReviewImageVO vo) {
		shopP003_d001DAO.insertShopReviewImage(vo);
	}
}
