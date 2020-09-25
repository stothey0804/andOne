package project.shop.p002.dao;

import java.util.List;

import project.shop.p002.vo.P002ShopDetailVO;

public interface P002_d001DAO {
	
	public P002ShopDetailVO getShopDetail(P002ShopDetailVO vo);
	public List<P002ShopDetailVO> getShopList(P002ShopDetailVO vo);
	
}
