package project.club.vo;

import org.springframework.stereotype.Component;

@Component
public class ClubArticleReplyVO {
	private String car_content,car_id,m_nickname,ca_id,car_date,m_id;
	private byte[] m_img;
	private String e_m_img;

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getE_m_img() {
		return e_m_img;
	}

	public void setE_m_img(String e_m_img) {
		this.e_m_img = e_m_img;
	}

	public String getCar_date() {
		return car_date;
	}

	public void setCar_date(String car_date) {
		this.car_date = car_date;
	}

	public String getCa_id() {
		return ca_id;
	}

	public void setCa_id(String ca_id) {
		this.ca_id = ca_id;
	}

	public byte[] getM_img() {
		return m_img;
	}

	public void setM_img(byte[] m_img) {
		this.m_img = m_img;
	}

	public String getCar_content() {
		return car_content;
	}

	public void setCar_content(String car_content) {
		this.car_content = car_content;
	}

	public String getCar_id() {
		return car_id;
	}

	public void setCar_id(String car_id) {
		this.car_id = car_id;
	}

	public String getM_nickname() {
		return m_nickname;
	}

	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	
}
