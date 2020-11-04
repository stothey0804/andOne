package project.and.p003.vo;

import org.springframework.stereotype.Component;

@Component
public class AndP003ChatContentVO {
	private String one_id;
	private String one_type;
	private String m_id;
	private String msg_content;
	private String msg_date;
	private String msg_id;
	private String m_nickname;
	
	
	
	public String getOne_id() {
		return one_id;
	}
	public void setOne_id(String one_id) {
		this.one_id = one_id;
	}
	public String getOne_type() {
		return one_type;
	}
	public void setOne_type(String one_type) {
		this.one_type = one_type;
	}
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
	public String getMsg_content() {
		return msg_content;
	}
	public void setMsg_content(String msg_content) {
		this.msg_content = msg_content;
	}
	public String getMsg_date() {
		return msg_date;
	}
	public void setMsg_date(String msg_date) {
		this.msg_date = msg_date;
	}
	public String getMsg_id() {
		return msg_id;
	}
	public void setMsg_id(String msg_id) {
		this.msg_id = msg_id;
	}
	
}
