package project.shop.p003.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

public interface ShopP003_d001Service {
	public boolean checkShopReview(ShopP003ShopReviewVO vo);
	public void insertShopReview(ShopP003ShopReviewVO vo);
	public void updateShopReview(ShopP003ShopReviewVO vo);
	public void insertShopReviewImage(ShopP003ShopReviewImageVO vo);
	public void deleteShopReviewImage(ShopP003ShopReviewImageVO vo);
	public boolean isDuplicate(ShopP003ShopReviewImageVO vo);
	public void updateShopReviewImage(ShopP003ShopReviewImageVO vo);
	public int selectShopReviewListCnt(Map<String,String> searchParam);
	public List<ShopP003ShopReviewVO> getShopReviewListByPaging(Map<String,String> searchParam);
	public boolean loginCheck(HttpServletRequest request);
	public void deleteShopReview(ShopP003ShopReviewVO vo);
}
