package project.shop.p003.vo;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class ShopP003ShopReviewVO {
	private String s_id;
	private String m_id;
	private String sr_date;
	private String sr_score;
	private String sr_content;
	private String sr_public;
	private String sr_editor;
	private String sr_editdate;
	private String m_nickname;
	private byte[] m_img;
	private List<ShopP003ShopReviewImageVO> shopReviewImage;
	
	
	
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public byte[] getM_img() {
		return m_img;
	}
	public void setM_img(byte[] m_img) {
		this.m_img = m_img;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getSr_date() {
		return sr_date;
	}
	public void setSr_date(String sr_date) {
		this.sr_date = sr_date;
	}
	public String getSr_score() {
		return sr_score;
	}
	public void setSr_score(String sr_score) {
		this.sr_score = sr_score;
	}
	public String getSr_content() {
		return sr_content;
	}
	public void setSr_content(String sr_content) {
		this.sr_content = sr_content;
	}
	public String getSr_public() {
		return sr_public;
	}
	public void setSr_public(String sr_public) {
		this.sr_public = sr_public;
	}
	public String getSr_editor() {
		return sr_editor;
	}
	public void setSr_editor(String sr_editor) {
		this.sr_editor = sr_editor;
	}
	public String getSr_editdate() {
		return sr_editdate;
	}
	public void setSr_editdate(String sr_editdate) {
		this.sr_editdate = sr_editdate;
	}
	public List<ShopP003ShopReviewImageVO> getShopReviewImage() {
		return shopReviewImage;
	}
	public void setShopReviewImage(List<ShopP003ShopReviewImageVO> shopReviewImage) {
		this.shopReviewImage = shopReviewImage;
	}
	
	
}
