package project.club.vo;

import java.util.HashMap;

import org.springframework.stereotype.Component;

@Component
public class ClubArticleImgVO {
	private HashMap<String, Object> articleImg;
	private String resultArticleImg;
	public String getResultArticleImg() {
		return resultArticleImg;
	}
	public void setResultArticleImg(String resultArticleImg) {
		this.resultArticleImg = resultArticleImg;
	}
	public HashMap<String, Object> getArticleImg() {
		return articleImg;
	}
	public void setArticleImg(HashMap<String, Object> articleImg) {
		this.articleImg = articleImg;
	}
	
}
