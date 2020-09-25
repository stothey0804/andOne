package club.p001.vo;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class P001_d001VO {
	public P001_d001VO() {
		System.out.println("clubVO 생성자 호출");
	}
	private String c_id;
	private String c_name;
	private String c_content;
	private String c_membercnt;
	private String c_category;
	private String c_hashtag;
	private List<P001_d001articleVO> articleList;
	
	public List<P001_d001articleVO> getArticleList() {
		return articleList;
	}
	public void setArticleList(List<P001_d001articleVO> articleList) {
		this.articleList = articleList;
	}
	public String getC_id() {
		return c_id;
	}
	public void setC_id(String c_id) {
		this.c_id = c_id;
	}
	public String getC_hashtag() {
		return c_hashtag;
	}
	public void setC_hashtag(String c_hashtag) {
		this.c_hashtag = c_hashtag;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public String getC_membercnt() {
		return c_membercnt;
	}
	public void setC_membercnt(String c_membercnt) {
		this.c_membercnt = c_membercnt;
	}
	public String getC_category() {
		return c_category;
	}
	public void setC_category(String c_category) {
		this.c_category = c_category;
	}
	
}
