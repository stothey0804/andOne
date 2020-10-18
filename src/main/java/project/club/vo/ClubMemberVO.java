package project.club.vo;

import org.springframework.stereotype.Component;

@Component
public class ClubMemberVO {
	private String m_id;
	private String cm_rank;
	private byte[] userImg;
	private String resultUserImg;
	private String m_nickname;
	private String cm_joindate;
	private String cm_intro;

	public String getCm_intro() {
		return cm_intro;
	}
	public void setCm_intro(String cm_intro) {
		this.cm_intro = cm_intro;
	}
	public String getResultUserImg() {
		return resultUserImg;
	}
	public void setResultUserImg(String resultUserImg) {
		this.resultUserImg = resultUserImg;
	}
	public byte[] getUserImg() {
		return userImg;
	}
	public void setUserImg(byte[] userImg) {
		this.userImg = userImg;
	}
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public String getCm_joindate() {
		return cm_joindate;
	}
	public void setCm_joindate(String cm_joindate) {
		this.cm_joindate = cm_joindate;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getCm_rank() {
		return cm_rank;
	}
	public void setCm_rank(String cm_rank) {
		this.cm_rank = cm_rank;
	}
	
}
