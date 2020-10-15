package project.root.p003.vo;

public class RootP003VO {
	String n_id, n_title, n_content, n_date, n_editor, n_editdate;

	public RootP003VO() {
		System.out.println("KakaoPayReady VO생성");
	}
	
	public RootP003VO(String n_title, String n_content) {
		super();
		this.n_title = n_title;
		this.n_content = n_content;
	}
	
	
	public RootP003VO(String n_id, String n_title, String n_content) {
		super();
		this.n_id = n_id;
		this.n_title = n_title;
		this.n_content = n_content;
	}

	/* getter, setter */

	
	public String getN_id() {
		return n_id;
	}

	public String getN_editor() {
		return n_editor;
	}

	public void setN_editor(String n_editor) {
		this.n_editor = n_editor;
	}

	public String getN_editdate() {
		return n_editdate;
	}

	public void setN_editdate(String n_editdate) {
		this.n_editdate = n_editdate;
	}

	public void setN_id(String n_id) {
		this.n_id = n_id;
	}

	public String getN_title() {
		return n_title;
	}

	public void setN_title(String n_title) {
		this.n_title = n_title;
	}

	public String getN_content() {
		return n_content;
	}

	public void setN_content(String n_content) {
		this.n_content = n_content;
	}

	public String getN_date() {
		return n_date;
	}

	public void setN_date(String n_date) {
		this.n_date = n_date;
	}
	
	
}
