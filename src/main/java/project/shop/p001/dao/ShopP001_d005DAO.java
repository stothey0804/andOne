package project.shop.p001.dao;

import project.shop.p001.vo.ShopP001BmemberVO;

public interface ShopP001_d005DAO {
	public String selectPwdById(String bm_id);
	public void updateBmember(ShopP001BmemberVO vo);
	public String searchOverlapEmail(String email);
	public String searchOverlapPhone(String phone);
	public void deleteBmember(String bm_id);
	public void deleteShop(String s_id);
	public String getShopIdByBmemberId(String bm_id);
}
