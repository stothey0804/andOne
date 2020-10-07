package project.shop.p002.dao;

import java.util.List;
import java.util.Map;

import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

public interface ShopP002_d001DAO {
	
	public List<ShopP002ShopDetailVO> getShopList(ShopP002ShopDetailVO vo);
	public ShopP002ShopDetailVO getShopDetail(ShopP002ShopDetailVO vo);
	public ShopP003ShopReviewVO getShopReview(ShopP003ShopReviewVO vo);
	public void updateShopImage(ShopP002ShopImageVO vo);
	public void updateShopReviewImage(ShopP003ShopReviewImageVO vo);
	public Map<String, Object> getShopImage();
}
