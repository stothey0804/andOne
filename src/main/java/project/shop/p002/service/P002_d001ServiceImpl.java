package project.shop.p002.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p002.dao.P002_d001DAO;
import project.shop.p002.vo.P002ShopDetailVO;

@Service
public class P002_d001ServiceImpl implements P002_d001Service {
	
	@Autowired
	private P002_d001DAO p002_d001DAO;
	
	@Override
	public P002ShopDetailVO getShopDetail(P002ShopDetailVO vo) {
		return p002_d001DAO.getShopDetail(vo);
	}

	@Override
	public List<P002ShopDetailVO> getShopList(P002ShopDetailVO vo) {
		return p002_d001DAO.getShopList(vo);
	}

}
