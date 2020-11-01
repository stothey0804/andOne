package project.shop.p001.dao;

import project.shop.p001.vo.ShopP001BmemberVO;

public interface ShopP001_d003DAO {
	public String findId(ShopP001BmemberVO vo);
	public String selectOverlapEmail(String email);

}
