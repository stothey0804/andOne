package project.club.vo;

import org.springframework.stereotype.Component;

@Component
public class ClubMemberVO {
	private String m_id;
	private String cm_rank;
	
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
