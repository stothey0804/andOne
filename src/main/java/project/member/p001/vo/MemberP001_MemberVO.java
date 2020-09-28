package project.member.p001.vo;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class MemberP001_MemberVO {
	private String m_id, m_email, m_pwd, m_phonenumber, m_nickname, m_gender, m_age, m_joindate, m_editor, m_editdate, m_score;
	private MultipartFile m_img;
	
	public MemberP001_MemberVO() {
	}

	public MemberP001_MemberVO(String m_email, String m_pwd, String m_phonenumber, String m_nickname, String m_gender, String m_age) {
		super();
		this.m_email = m_email;
		this.m_pwd = m_pwd;
		this.m_phonenumber = m_phonenumber;
		this.m_nickname = m_nickname;
		this.m_gender = m_gender;
		this.m_age = m_age;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public String getM_pwd() {
		return m_pwd;
	}

	public void setM_pwd(String m_pwd) {
		this.m_pwd = m_pwd;
	}

	public String getM_phonenumber() {
		return m_phonenumber;
	}

	public void setM_phonenumber(String m_phonenumber) {
		this.m_phonenumber = m_phonenumber;
	}

	public String getM_nickname() {
		return m_nickname;
	}

	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}

	public String getM_gender() {
		return m_gender;
	}

	public void setM_gender(String m_gender) {
		this.m_gender = m_gender;
	}

	public String getM_age() {
		return m_age;
	}

	public void setM_age(String m_age) {
		this.m_age = m_age;
	}

	public String getM_joindate() {
		return m_joindate;
	}

	public void setM_joindate(String m_joindate) {
		this.m_joindate = m_joindate;
	}

	public MultipartFile getM_img() {
		return m_img;
	}

	public void setM_img(MultipartFile m_img) {
		this.m_img = m_img;
	}

	public String getM_editor() {
		return m_editor;
	}

	public void setM_editor(String m_editor) {
		this.m_editor = m_editor;
	}

	public String getM_editdate() {
		return m_editdate;
	}

	public void setM_editdate(String m_editdate) {
		this.m_editdate = m_editdate;
	}

	public String getM_score() {
		return m_score;
	}

	public void setM_score(String m_score) {
		this.m_score = m_score;
	}

	@Override
	public String toString() {
		return "MemberP001_MemberVO [m_id=" + m_id + ", m_email=" + m_email + ", m_pwd=" + m_pwd + ", m_phonenumber="
				+ m_phonenumber + ", m_nickname=" + m_nickname + ", m_gender=" + m_gender + ", m_age=" + m_age
				+ ", m_joindate=" + m_joindate + ", m_editor=" + m_editor + ", m_editdate=" + m_editdate + ", m_score="
				+ m_score + ", m_img=" + m_img + "]";
	}
	
	
	
	
}
