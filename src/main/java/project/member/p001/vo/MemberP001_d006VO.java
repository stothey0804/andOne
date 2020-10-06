package project.member.p001.vo;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class MemberP001_d006VO {
	private String m_id;
	private String m_phonenumber;
	private String m_email;
	private String m_gender;
	private String m_nickname;
	private String m_age;
	private String m_joinDate;
	private String m_locate;
	private String m_pwd;
	private String m_editor;
	private String m_editdate;
	private String m_score;
	private String reportCnt;
	private String p_currentpoint;
	private String qnaCnt;
	private String joinClubCnt;
	private String reviewCnt;
	private List list;
	private String searchKeyword;
	private String searchCondition;
	
	
	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getM_joinDate() {
		return m_joinDate;
	}

	public void setM_joinDate(String m_joinDate) {
		this.m_joinDate = m_joinDate;
	}

	public String getM_locate() {
		return m_locate;
	}

	public void setM_locate(String m_locate) {
		this.m_locate = m_locate;
	}

	public String getM_pwd() {
		return m_pwd;
	}

	public void setM_pwd(String m_pwd) {
		this.m_pwd = m_pwd;
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
	
	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public String getM_score() {
		return m_score;
	}

	public void setM_score(String m_score) {
		this.m_score = m_score;
	}

	public String getReportCnt() {
		return reportCnt;
	}

	public void setReportCnt(String reportCnt) {
		this.reportCnt = reportCnt;
	}

	public String getP_currentpoint() {
		return p_currentpoint;
	}

	public void setP_currentpoint(String p_currentpoint) {
		this.p_currentpoint = p_currentpoint;
	}

	public String getQnaCnt() {
		return qnaCnt;
	}

	public void setQnaCnt(String qnaCnt) {
		this.qnaCnt = qnaCnt;
	}

	public String getJoinClubCnt() {
		return joinClubCnt;
	}

	public void setJoinClubCnt(String joinClubCnt) {
		this.joinClubCnt = joinClubCnt;
	}

	public String getReviewCnt() {
		return reviewCnt;
	}

	public void setReviewCnt(String reviewCnt) {
		this.reviewCnt = reviewCnt;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_phonenumber() {
		return m_phonenumber;
	}

	public void setM_phonenumber(String m_phonenumber) {
		this.m_phonenumber = m_phonenumber;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public String getM_gender() {
		return m_gender;
	}

	public void setM_gender(String m_gender) {
		this.m_gender = m_gender;
	}

	public String getM_nickname() {
		return m_nickname;
	}

	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}

	public String getM_age() {
		return m_age;
	}

	public void setM_age(String m_age) {
		this.m_age = m_age;
	}

	public MemberP001_d006VO() {
		System.out.println("MemberVO 생성자 호출");
	}
	
}
