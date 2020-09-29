package project.shop.p001.service;


import java.util.Map;

import org.springframework.dao.DataAccessException;

import project.shop.p001.vo.ShopP001_d001VO;

public interface ShopP001_d001Service {
	public int IdCheck(String bm_id) throws DataAccessException;
	public int EmailCheck(String bm_email) throws DataAccessException;
	public int addBmember(ShopP001_d001VO vo) throws DataAccessException;

}
