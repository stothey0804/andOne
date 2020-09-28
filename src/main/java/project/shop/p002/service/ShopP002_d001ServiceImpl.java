package project.shop.p002.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p002.dao.ShopP002_d001DAO;
import project.shop.p002.vo.ShopP002ShopDetailVO;

@Service
public class ShopP002_d001ServiceImpl implements ShopP002_d001Service {
	
	@Autowired
	private ShopP002_d001DAO shopP002_d001DAO;
	
	@Override
	public List<ShopP002ShopDetailVO> getShopList(ShopP002ShopDetailVO vo) {
		return shopP002_d001DAO.getShopList(vo);
	}

}
