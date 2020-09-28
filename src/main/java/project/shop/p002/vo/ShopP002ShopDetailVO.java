package project.shop.p002.vo;

import java.util.List;

import org.springframework.stereotype.Component;

import project.shop.p003.vo.ShopP003ShopReviewVO;

@Component
public class ShopP002ShopDetailVO {
		private String s_id;
		private String s_category;
		private String s_name;
		private String s_score;
		private String s_content;
		private String bm_id;
		private String s_locate;
		private String s_phoneNumber;
		private String s_hashtag;
		private String reviewCount;
		private String gc_name;
		private String searchCondition;
		private String searchKeyword;
		private String status;
		private String filter;
		private List<ShopP003ShopReviewVO> shopReviewList;
		private List<ShopP002ShopImageVO> shopImage;
		
		
		public String getFilter() {
			return filter;
		}
		public void setFilter(String filter) {
			this.filter = filter;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		public String getSearchCondition() {
			return searchCondition;
		}
		public void setSearchCondition(String searchCondition) {
			this.searchCondition = searchCondition;
		}
		public String getSearchKeyword() {
			return searchKeyword;
		}
		public void setSearchKeyword(String searchKeyword) {
			this.searchKeyword = searchKeyword;
		}
		public String getReviewCount() {
			return reviewCount;
		}
		public void setReviewCount(String reviewCount) {
			this.reviewCount = reviewCount;
		}
		public String getGc_name() {
			return gc_name;
		}
		public void setGc_name(String gc_name) {
			this.gc_name = gc_name;
		}
		public String getS_id() {
			return s_id;
		}
		public void setS_id(String s_id) {
			this.s_id = s_id;
		}
		public String getS_category() {
			return s_category;
		}
		public void setS_category(String s_category) {
			this.s_category = s_category;
		}
		public String getS_name() {
			return s_name;
		}
		public void setS_name(String s_name) {
			this.s_name = s_name;
		}
		public String getS_score() {
			return s_score;
		}
		public void setS_score(String s_score) {
			this.s_score = s_score;
		}
		public String getS_content() {
			return s_content;
		}
		public void setS_content(String s_content) {
			this.s_content = s_content;
		}
		public String getBm_id() {
			return bm_id;
		}
		public void setBm_id(String bm_id) {
			this.bm_id = bm_id;
		}
		public String getS_locate() {
			return s_locate;
		}
		public void setS_locate(String s_locate) {
			this.s_locate = s_locate;
		}
		public String getS_phoneNumber() {
			return s_phoneNumber;
		}
		public void setS_phoneNumber(String s_phoneNumber) {
			this.s_phoneNumber = s_phoneNumber;
		}
		public String getS_hashtag() {
			return s_hashtag;
		}
		public void setS_hashtag(String s_hashtag) {
			this.s_hashtag = s_hashtag;
		}
		public List<ShopP003ShopReviewVO> getShopReviewList() {
			return shopReviewList;
		}
		public void setShopReviewList(List<ShopP003ShopReviewVO> shopReviewList) {
			this.shopReviewList = shopReviewList;
		}
		public List<ShopP002ShopImageVO> getShopImage() {
			return shopImage;
		}
		public void setShopImage(List<ShopP002ShopImageVO> shopImage) {
			this.shopImage = shopImage;
		}
		
		
		
}
