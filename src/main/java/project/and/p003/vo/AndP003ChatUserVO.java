package project.and.p003.vo;

import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class AndP003ChatUserVO {
	private String m_id;
	private String m_nickname;
	private Map<String, Object> m_imgEncoder;
	private String m_encodedImg;
	
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public Map<String, Object> getM_imgEncoder() {
		return m_imgEncoder;
	}
	public void setM_imgEncoder(Map<String, Object> m_imgEncoder) {
		this.m_imgEncoder = m_imgEncoder;
	}
	public String getM_encodedImg() {
		return m_encodedImg;
	}
	public void setM_encodedImg(String m_encodedImg) {
		this.m_encodedImg = m_encodedImg;
	}
	
	
}
