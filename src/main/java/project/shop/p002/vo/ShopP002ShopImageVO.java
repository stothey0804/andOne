package project.shop.p002.vo;

import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class ShopP002ShopImageVO {
	private String s_id;
	private String si_idx;
	private MultipartFile si_img;
	private Map<String, Object> si_imgEncoder;
	private String si_encodedImg;
	private String si_editor;
	private String si_editdate;
	
	
	
	public String getSi_encodedImg() {
		return si_encodedImg;
	}
	public void setSi_encodedImg(String si_encodedImg) {
		this.si_encodedImg = si_encodedImg;
	}
	public Map<String, Object> getSi_imgEncoder() {
		return si_imgEncoder;
	}
	public void setSi_imgEncoder(Map<String, Object> si_imgEncoder) {
		this.si_imgEncoder = si_imgEncoder;
	}
	public MultipartFile getSi_img() {
		return si_img;
	}
	public void setSi_img(MultipartFile si_img) {
		this.si_img = si_img;
	}
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
