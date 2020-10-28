package project.shop.p002.dao;

import java.util.List;
import java.util.Map;

import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

public interface ShopP002_d001DAO {
	
	public List<ShopP002ShopDetailVO> getShopList(Map<String,Object> param);
	public ShopP002ShopDetailVO getShopDetail(Map<String,Object> param);
	public ShopP003ShopReviewVO getShopReview(ShopP003ShopReviewVO vo);
	public void updateShopImage(ShopP002ShopImageVO vo);
	public void updateShopReviewImage(ShopP003ShopReviewImageVO vo);
	public Map<String, Object> getShopImage();
	public List<String> getAllHashtag();
	public void updatePopularHashtag(String result);
	public String getPopularHashtag();
	public List<String> getMemberIdFromShopReview(String s_id);
	public int getShopListCnt(Map<String,Object> param);
}
