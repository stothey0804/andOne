package project.shop.p001.service;

import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;

public interface ShopP001_d006Service {
	public String searchOverlapShopId(String shopId);
	public String searchOverlapShopPhone(String phone);
	public void insertShop(ShopP002ShopDetailVO vo);
	public void insertShopImage(ShopP002ShopImageVO vo);
	public void updateShop(ShopP002ShopDetailVO vo);
	public void updateShopImage(ShopP002ShopImageVO vo);

}
