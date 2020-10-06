package project.member.p001.vo;

import org.springframework.stereotype.Component;

@Component
public class MemberP001_d006ListVO {
	private String one_title;
	private String one_date;
	private String p_changepoint;
	private String one_state;
	public String getP_changepoint() {
		return p_changepoint;
	}

	public void setP_changepoint(String p_changepoint) {
		this.p_changepoint = p_changepoint;
	}


	public String getOne_title() {
		return one_title;
	}

	public void setOne_title(String one_title) {
		this.one_title = one_title;
	}

	public String getOne_date() {
		return one_date;
	}

	public void setOne_date(String one_date) {
		this.one_date = one_date;
	}

	public String getOne_state() {
		return one_state;
	}

	public void setOne_state(String one_state) {
		this.one_state = one_state;
	}

	public MemberP001_d006ListVO() {
		System.out.println("MemberPointListVO 생성자 호출");
	}
	
}
