package project.club.vo;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class ClubVO {
	
	public ClubVO() {
		System.out.println("clubVO 생성자 호출");
	}
	
	private String c_id;
	private String c_name;
	private String c_content;
	private String c_membercnt;
	private String c_membermax;
	private String c_category;
	private String c_hashtag;
	private MultipartFile c_img;
	private byte[] c_imgByte;
	private String resultImg;
	private String c_openingdate;
	private List<ClubArticleVO> articleList;
	
	public String getResultImg() {
		return resultImg;
	}
	public void setResultImg(String resultImg) {
		this.resultImg = resultImg;
	}

	public String getC_openingdate() {
		return c_openingdate;
	}
	public void setC_openingdate(String c_openingdate) {
		this.c_openingdate = c_openingdate;
	}

	
	public byte[] getC_imgByte() {
		return c_imgByte;
	}
	public void setC_imgByte(byte[] c_imgByte) {
		this.c_imgByte = c_imgByte;
	}
	public String getC_membermax() {
		return c_membermax;
	}
	public void setC_membermax(String c_membermax) {
		this.c_membermax = c_membermax;
	}
	public MultipartFile getC_img() {
		return c_img;
	}
	public void setC_img(MultipartFile c_img) {
		this.c_img = c_img;
	}
	public List<ClubArticleVO> getArticleList() {
		return articleList;
	}
	public void setArticleList(List<ClubArticleVO> articleList) {
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
