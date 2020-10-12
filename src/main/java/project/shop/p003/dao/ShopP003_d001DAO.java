package project.shop.p003.dao;

import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

public interface ShopP003_d001DAO {
	public boolean checkShopReview(ShopP003ShopReviewVO vo);
	public void insertShopReview(ShopP003ShopReviewVO vo);
	public void insertShopReviewImage(ShopP003ShopReviewImageVO vo);
}
