package project.shop.p003.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p003.dao.ShopP003_d001DAO;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Service
public class ShopP003_d001ServiceImpl implements ShopP003_d001Service{
	
	@Autowired
	private ShopP003_d001DAO shopP003_d001DAO;

	@Override
	public boolean checkShopReview(ShopP003ShopReviewVO vo) {
		return shopP003_d001DAO.checkShopReview(vo);
	}

	@Override
	public void insertShopReview(ShopP003ShopReviewVO vo) {
		shopP003_d001DAO.insertShopReview(vo);
	}

	@Override
	public void insertShopReviewImage(ShopP003ShopReviewImageVO vo) {
		shopP003_d001DAO.insertShopReviewImage(vo);
	}

	@Override
	public void updateShopReview(ShopP003ShopReviewVO vo) {
		shopP003_d001DAO.updateShopReview(vo);
	}

	@Override
	public void deleteShopReviewImage(ShopP003ShopReviewImageVO vo) {
		shopP003_d001DAO.deleteShopReviewImage(vo);
	}

	@Override
	public boolean isDuplicate(ShopP003ShopReviewImageVO vo) {
		return shopP003_d001DAO.isDuplicate(vo);
	}

	@Override
	public void updateShopReviewImage(ShopP003ShopReviewImageVO vo) {
		shopP003_d001DAO.updateShopReviewImage(vo);
	}

	@Override
	public int selectShopReviewListCnt(Map<String,String> searchParam) {
		return shopP003_d001DAO.selectShopReviewListCnt(searchParam);
	}

	@Override
	public List<ShopP003ShopReviewVO> getShopReviewListByPaging(Map<String, String> searchParam) {
		return shopP003_d001DAO.getShopReviewListByPaging(searchParam);
	}

	@Override
	public boolean loginCheck(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		boolean result = false;
		if(session!=null) {
			if(session.getAttribute("m_id")!=null && session.getAttribute("isLogOn")!=null){
				result = true;
			}
		}
		return result;
	}

	@Override
	public void deleteShopReview(ShopP003ShopReviewVO vo) {
		shopP003_d001DAO.deleteShopReview(vo);
	}
}
