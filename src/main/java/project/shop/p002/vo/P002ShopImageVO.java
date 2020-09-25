package project.shop.p002.vo;

import org.springframework.stereotype.Component;

@Component
public class P002ShopImageVO {
	private String s_id;
	private String si_idx;
	private byte[] si_img;
	private String si_editor;
	private String si_editdate;
	
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getSi_idx() {
		return si_idx;
	}
	public void setSi_idx(String si_idx) {
		this.si_idx = si_idx;
	}
	public byte[] getSi_img() {
		return si_img;
	}
	public void setSi_img(byte[] si_img) {
		this.si_img = si_img;
	}
	public String getSi_editor() {
		return si_editor;
	}
	public void setSi_editor(String si_editor) {
		this.si_editor = si_editor;
	}
	public String getSi_editdate() {
		return si_editdate;
	}
	public void setSi_editdate(String si_editdate) {
		this.si_editdate = si_editdate;
	}
	
	
}
