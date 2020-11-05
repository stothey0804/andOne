package project.and.p003.vo;

import org.springframework.stereotype.Component;

@Component
public class AndP003ChatRoomVO {

	private String one_type;
	private String one_id;
	private String one_title;
	private String latestMessage;
	private String msg_date;
	
	
	
	public String getMsg_date() {
		return msg_date;
	}
	public void setMsg_date(String msg_date) {
		this.msg_date = msg_date;
	}
	public String getLatestMessage() {
		return latestMessage;
	}
	public void setLatestMessage(String latestMessage) {
		this.latestMessage = latestMessage;
	}
	public String getOne_type() {
		return one_type;
	}
	public void setOne_type(String one_type) {
		this.one_type = one_type;
	}
	public String getOne_id() {
		return one_id;
	}
	public void setOne_id(String one_id) {
		this.one_id = one_id;
	}
	public String getOne_title() {
		return one_title;
	}
	public void setOne_title(String one_title) {
		this.one_title = one_title;
	}
	
	public AndP003ChatRoomVO() {
		
	}
	
}
