package project.shop.p003.dao;

import java.util.List;
import java.util.Map;

import project.shop.p002.vo.ShopP002ShopImageVO;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

public interface ShopP003_d001DAO {
	public boolean checkShopReview(ShopP003ShopReviewVO vo);
	public void insertShopReview(ShopP003ShopReviewVO vo);
	public void updateShopReview(ShopP003ShopReviewVO vo);
	public void insertShopReviewImage(ShopP003ShopReviewImageVO vo);
	public void deleteShopReviewImage(ShopP003ShopReviewImageVO vo);
	public boolean isDuplicate(ShopP003ShopReviewImageVO vo);
	public boolean isDuplicate(ShopP002ShopImageVO vo);
	public void updateShopReviewImage(ShopP003ShopReviewImageVO vo);
	public int selectShopReviewListCnt(String s_id);
	public int selectMyShopReviewListCnt(String m_id);
	public List<ShopP003ShopReviewVO> getShopReviewListByPaging(Map<String,String> searchParam);
	public List<ShopP003ShopReviewVO> getMyShopReviewListByPaging(Map<String,String> searchParam);
	public void deleteShopReview(ShopP003ShopReviewVO vo);
	public void updateShopScore(String s_id);
	public void initShopScore(String s_id);
}
