package project.club.vo;

import org.springframework.stereotype.Component;

@Component
public class ClubMemberVO {
	private String m_id;
	private String cm_rank;
	private byte[] userImg;
	private String resultUserImg;
	private String m_nickname;
	private String m_joindate;

public String getResultUserImg() {
		return resultUserImg;
	}
	public void setResultUserImg(String resultUserImg) {
		this.resultUserImg = resultUserImg;
	}
	//	public String getStringUserImg() {
//		return stringUserImg;
//	}
//	public void setStringUserImg(String stringUserImg) {
//		this.stringUserImg = stringUserImg;
//	}
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
	public String getM_joindate() {
		return m_joindate;
	}
	public void setM_joindate(String m_joindate) {
		this.m_joindate = m_joindate;
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
