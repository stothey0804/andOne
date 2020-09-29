package project.shop.p001.vo;

import org.springframework.stereotype.Component;

@Component
public class ShopP001_d001VO {
	private String bm_id, bm_pwd, bm_name, bm_email, bm_joinDate, bm_phoneNumber;
	
	public ShopP001_d001VO() {
	}
	
	public ShopP001_d001VO(String bm_id, String bm_pwd, String bm_name, String bm_email, String bm_joinDate, String bm_phoneNumber) {
		this.bm_id= bm_id;
		this.bm_pwd = bm_pwd;
		this.bm_name = bm_name;
		this.bm_email = bm_email;
		this.bm_joinDate = bm_joinDate;
		this.bm_phoneNumber = bm_phoneNumber;
	}


	public String getBm_id() {
		return bm_id;
	}

	public void setBm_id(String bm_id) {
		this.bm_id = bm_id;
	}

	public String getBm_pwd() {
		return bm_pwd;
	}

	public void setBm_pwd(String bm_pwd) {
		this.bm_pwd = bm_pwd;
	}

	public String getBm_name() {
		return bm_name;
	}

	public void setBm_name(String bm_name) {
		this.bm_name = bm_name;
	}

	public String getBm_email() {
		return bm_email;
	}

	public void setBm_email(String bm_email) {
		this.bm_email = bm_email;
	}

	public String getBm_joinDate() {
		return bm_joinDate;
	}

	public void setBm_joinDate(String bm_joinDate) {
		this.bm_joinDate = bm_joinDate;
	}

	public String getBm_phoneNumber() {
		return bm_phoneNumber;
	}

	public void setBm_phoneNumber(String bm_phoneNumber) {
		this.bm_phoneNumber = bm_phoneNumber;
	}

}

