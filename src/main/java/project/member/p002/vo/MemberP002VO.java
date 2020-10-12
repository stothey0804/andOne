package project.member.p002.vo;

public class MemberP002VO {
	private String q_id, q_type, m_id, q_subject, q_date, q_content, q_state, q_checked, q_reply, q_type_id;
	
	public MemberP002VO() {
		// TODO Auto-generated constructor stub
	}

	public MemberP002VO(String q_type, String m_id, String q_subject, String q_content) {
		super();
		this.q_type = q_type;
		this.m_id = m_id;
		this.q_subject = q_subject;
		this.q_content = q_content;
	}

	

	public String getQ_type_id() {
		return q_type_id;
	}

	public void setQ_type_id(String q_type_id) {
		this.q_type_id = q_type_id;
	}

	public String getQ_id() {
		return q_id;
	}

	public void setQ_id(String q_id) {
		this.q_id = q_id;
	}

	public String getQ_type() {
		return q_type;
	}

	public void setQ_type(String q_type) {
		this.q_type = q_type;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getQ_subject() {
		return q_subject;
	}

	public void setQ_subject(String q_subject) {
		this.q_subject = q_subject;
	}

	public String getQ_date() {
		return q_date;
	}

	public void setQ_date(String q_date) {
		this.q_date = q_date;
	}

	public String getQ_content() {
		return q_content;
	}

	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}

	public String getQ_state() {
		return q_state;
	}

	public void setQ_state(String q_state) {
		this.q_state = q_state;
	}

	public String getQ_checked() {
		return q_checked;
	}

	public void setQ_checked(String q_checked) {
		this.q_checked = q_checked;
	}

	public String getQ_reply() {
		return q_reply;
	}

	public void setQ_reply(String q_reply) {
		this.q_reply = q_reply;
	}
	
	
}
