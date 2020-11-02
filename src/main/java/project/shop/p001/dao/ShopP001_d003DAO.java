package project.shop.p001.dao;

import java.util.Map;

import project.shop.p001.vo.ShopP001BmemberVO;

public interface ShopP001_d003DAO {
	public String findId(ShopP001BmemberVO vo);
	public String selectOverlapEmail(String email);
	public Map<String,String> selectIdPwdByEmail(String bm_email);
	public void updatePwd(Map<String,String> paramMap);
}
