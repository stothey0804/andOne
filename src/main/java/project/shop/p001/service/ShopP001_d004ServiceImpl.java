package project.shop.p001.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p001.dao.ShopP001_d004DAO;
import project.shop.p001.vo.ShopP001StatisticsVO;

@Service
public class ShopP001_d004ServiceImpl implements ShopP001_d004Service{
	@Autowired
	ShopP001_d004DAO shopP001_d004DAO;

	@Override
	public ShopP001StatisticsVO sixMonthScoreStatistics(String s_id) {
		return shopP001_d004DAO.sixMonthScoreStatistics(s_id);
	}

	@Override
	public ShopP001StatisticsVO sixMonthReviewStatistics(String s_id) {
		// TODO Auto-generated method stub
		return shopP001_d004DAO.sixMonthReviewStatistics(s_id);
	}
}
