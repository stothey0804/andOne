package project.shop.p002.service;

import java.util.Base64;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.shop.p002.dao.ShopP002_d001DAO;
import project.shop.p002.vo.ShopP002ShopDetailVO;
import project.shop.p002.vo.ShopP002ShopImageVO;
import project.shop.p003.vo.ShopP003ShopReviewImageVO;
import project.shop.p003.vo.ShopP003ShopReviewVO;

@Service
public class ShopP002_d001ServiceImpl implements ShopP002_d001Service {
	
	@Autowired
	private ShopP002_d001DAO shopP002_d001DAO;
	
	@Override
	public List<ShopP002ShopDetailVO> getShopList(ShopP002ShopDetailVO vo) {
		return shopP002_d001DAO.getShopList(vo);
	}

	@Override
	public ShopP002ShopDetailVO getShopDetail(ShopP002ShopDetailVO vo) {
		return shopP002_d001DAO.getShopDetail(vo);
	}

	@Override
	public ShopP003ShopReviewVO getShopReview(ShopP003ShopReviewVO vo) {
		return shopP002_d001DAO.getShopReview(vo);
	}

	@Override
	public void updateShopImage(ShopP002ShopImageVO vo) {
		shopP002_d001DAO.updateShopImage(vo);
	}

	@Override
	public Map<String, Object> getShopImage() {
		return shopP002_d001DAO.getShopImage();
	}

	@Override
	public void updateShopReviewImage(ShopP003ShopReviewImageVO vo) {
		shopP002_d001DAO.updateShopReviewImage(vo);
		
	}

	@Override
	public List<String> getAllHashtag() {
		return shopP002_d001DAO.getAllHashtag();
	}

	@Override
	public void updatePopularHashtag(String result) {
		shopP002_d001DAO.updatePopularHashtag(result);
		
	}

	@Override
	public String getPopularHashtag() {
		return shopP002_d001DAO.getPopularHashtag();
	}

	@Override
	public List<String> getMemberIdFromShopReview(String s_id) {
		return shopP002_d001DAO.getMemberIdFromShopReview(s_id);
	}
	
	@Override
	public void shopImageEncoder(ShopP002ShopDetailVO vo) {
		int shopImageCount = vo.getShopImage().size();
		for(int i=0; i<shopImageCount; i++) {
			if(!vo.getShopImage().get(i).getSi_imgEncoder().isEmpty()) {
				byte[] encoded = Base64.getEncoder().encode((byte[])vo.getShopImage().get(i).getSi_imgEncoder().get("si_imgEncoder"));
				vo.getShopImage().get(i).setSi_encodedImg(new String(encoded));
				vo.getShopImage().get(i).setSi_imgEncoder(null);
			}
		}
	}
	
	@Override
	public void reviewImageEncoder(ShopP003ShopReviewVO vo) {
		int shopReviewImageCount = vo.getShopReviewImage().size();
		if(!vo.getM_imgEncoder().isEmpty()) {
			byte[] encoded1 = Base64.getEncoder().encode((byte[])vo.getM_imgEncoder().get("m_imgEncoder"));
			vo.setM_encodedImg(new String(encoded1));
			vo.setM_imgEncoder(null);
		}
		for(int i=0; i<shopReviewImageCount; i++) {
			if(!vo.getShopReviewImage().get(i).getRi_imgEncoder().isEmpty()) {
				byte[] encoded2 = Base64.getEncoder().encode((byte[])vo.getShopReviewImage().get(i).getRi_imgEncoder().get("ri_imgEncoder"));
				vo.getShopReviewImage().get(i).setRi_encodedImg(new String(encoded2));
				vo.getShopReviewImage().get(i).setRi_imgEncoder(null);
			}
		}
	}

}
