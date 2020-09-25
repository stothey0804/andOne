package project.club.p001.vo;

import org.springframework.stereotype.Component;

@Component
public class ClubP001_d001articleVO {
	public ClubP001_d001articleVO() {
		System.out.println("clubArticleVO 생성자 호출");
	}
	private String ca_id;
	private String ca_content;
	private String ca_date;
	private String m_id;
	private byte[] ca_img;
	private String ca_pin;
	public String getCa_pin() {
		return ca_pin;
	}
	public void setCa_pin(String ca_pin) {
		this.ca_pin = ca_pin;
	}
	
	public String getCa_id() {
		return ca_id;
	}
	public void setCa_id(String ca_id) {
		this.ca_id = ca_id;
	}
	public String getCa_content() {
		return ca_content;
	}
	public void setCa_content(String ca_content) {
		this.ca_content = ca_content;
	}
	public String getCa_date() {
		return ca_date;
	}
	public void setCa_date(String ca_date) {
		this.ca_date = ca_date;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public byte[] getCa_img() {
		return ca_img;
	}
	public void setCa_img(byte[] ca_img) {
		this.ca_img = ca_img;
	}
	
}
