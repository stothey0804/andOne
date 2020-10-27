package project.shop.p002.service;

import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
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
			if(vo.getShopImage().get(i).getSi_imgEncoder()!=null) {
				byte[] encoded = Base64.getEncoder().encode((byte[])vo.getShopImage().get(i).getSi_imgEncoder().get("si_imgEncoder"));
				vo.getShopImage().get(i).setSi_encodedImg(new String(encoded));
				vo.getShopImage().get(i).setSi_imgEncoder(null);
			}
		}
	}
	
	@Override
	public void reviewImageEncoder(ShopP003ShopReviewVO vo) {
		int shopReviewImageCount = vo.getShopReviewImage().size();
		if(vo.getM_imgEncoder()!=null) {
			byte[] encoded1 = Base64.getEncoder().encode((byte[])vo.getM_imgEncoder().get("m_imgEncoder"));
			vo.setM_encodedImg(new String(encoded1));
			vo.setM_imgEncoder(null);
		}
		for(int i=0; i<shopReviewImageCount; i++) {
			if(vo.getShopReviewImage().get(i).getRi_imgEncoder()!=null) {
				byte[] encoded2 = Base64.getEncoder().encode((byte[])vo.getShopReviewImage().get(i).getRi_imgEncoder().get("ri_imgEncoder"));
				vo.getShopReviewImage().get(i).setRi_encodedImg(new String(encoded2));
				vo.getShopReviewImage().get(i).setRi_imgEncoder(null);
			}
		}
	}
	
	@Override
	public void popularHashtagUpdate() {
		List<String> hashtagList = getAllHashtag();
		Map<String,Integer> hashtagMap = new HashMap<>();
		for(int i=0; i<hashtagList.size(); i++) {
			String[] parser = hashtagList.get(i).split(",");
			for(int j=0; j<parser.length; j++) {
				if(parser[j].equals("")) {
					continue;
				}else {
					if(hashtagMap.containsKey(parser[j])) {
						int value = (int)hashtagMap.get(parser[j]);
						value++;
						hashtagMap.replace(parser[j], value);
					}else {
						hashtagMap.put(parser[j], 1);
					}
				}
			}
		}
		List<String> keySetList = new ArrayList<>(hashtagMap.keySet());
		System.out.println("======> 정렬 전 입력된 값 확인");
		for(int i=0; i<keySetList.size(); i++) {
			System.out.println("해시태그 : #" + keySetList.get(i) + "  /  횟수 : " + hashtagMap.get(keySetList.get(i)));
		}
		Collections.sort(keySetList, (o1, o2) -> (hashtagMap.get(o2).compareTo(hashtagMap.get(o1))));
		System.out.println("======> 정렬 후 입력된 값 확인");
		for(int i=0; i<keySetList.size(); i++) {
			System.out.println("해시태그 : #" + keySetList.get(i) + "  /  횟수 : " + hashtagMap.get(keySetList.get(i)));
		}
		System.out.println("======>상위 4개 해시태그만 printout");
		String result = "";
		for(int i=0; i<4; i++) {
			result += keySetList.get(i);
			System.out.println("#"+keySetList.get(i));
			result += ",";
		}
		result = result.substring(0, result.length()-1);
		System.out.println("=======>DB에 들어갈 인기 해시태그");
		System.out.println(result);
		updatePopularHashtag(result);
	}

}
