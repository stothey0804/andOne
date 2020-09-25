package project.shop.p003.vo;

import org.springframework.stereotype.Component;

@Component
public class P003ShopReviewImageVO {
	private String s_id;
	private String m_id;
	private String ri_editor;
	private String ri_editdate;
	private String ri_idx;
	private byte[] ri_img;
	
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
	public String getRi_editor() {
		return ri_editor;
	}
	public void setRi_editor(String ri_editor) {
		this.ri_editor = ri_editor;
	}
	public String getRi_editdate() {
		return ri_editdate;
	}
	public void setRi_editdate(String ri_editdate) {
		this.ri_editdate = ri_editdate;
	}
	public String getRi_idx() {
		return ri_idx;
	}
	public void setRi_idx(String ri_idx) {
		this.ri_idx = ri_idx;
	}
	public byte[] getRi_img() {
		return ri_img;
	}
	public void setRi_img(byte[] ri_img) {
		this.ri_img = ri_img;
	}
	
	
}
