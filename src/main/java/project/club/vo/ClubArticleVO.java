package project.club.vo;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class ClubArticleVO {
	
	public ClubArticleVO() {
		System.out.println("clubArticleVO 생성자 호출");
	}
	private String c_id;
	private String ca_id;
	private String ca_content;
	private String ca_date;
	private String m_id;
	private String m_nickname;
	//이미지 첨부 List
	private List<MultipartFile> ca_img;
	private String ca_pin;
	private byte[] userImg;
	private String resultUserImg;
	private List<ClubArticleImgVO> articleImgList;
	
	public List<ClubArticleImgVO> getArticleImgList() {
		return articleImgList;
	}
	public void setArticleImgList(List<ClubArticleImgVO> articleImgList) {
		this.articleImgList = articleImgList;
	}
	public List<MultipartFile> getCa_img() {
		return ca_img;
	}
	public void setCa_img(List<MultipartFile> ca_img) {
		this.ca_img = ca_img;
	}
	public String getM_nickname() {
		return m_nickname;
	}
	public void setM_nickname(String m_nickname) {
		this.m_nickname = m_nickname;
	}
	public String getResultUserImg() {
		return resultUserImg;
	}
	public void setResultUserImg(String resultUserImg) {
		this.resultUserImg = resultUserImg;
	}
	public byte[] getUserImg() {
		return userImg;
	}
	public void setUserImg(byte[] userImg) {
		this.userImg = userImg;
	}
	public String getC_id() {
		return c_id;
	}
	public void setC_id(String c_id) {
		this.c_id = c_id;
	}
	public String getCa_pin() {
		return ca_pin;
	}
	public void setCa_pin(String ca_pin) {
		this.ca_pin = ca_pin;
	}
	
	public String getCa_id() {
		return ca_id;
	}
	public void setCa_id(String ca_id) {
		this.ca_id = ca_id;
	}
	public String getCa_content() {
		return ca_content;
	}
	public void setCa_content(String ca_content) {
		this.ca_content = ca_content;
	}
	public String getCa_date() {
		return ca_date;
	}
	public void setCa_date(String ca_date) {
		this.ca_date = ca_date;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	
}
