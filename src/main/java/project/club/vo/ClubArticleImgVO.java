package project.club.vo;

import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class ClubArticleImgVO {
	public ClubArticleImgVO(){
		System.out.println("gg");
	}
	private Map<String, Object> articleImg;
	private String resultArticleImg;
	public String getResultArticleImg() {
		return resultArticleImg;
	}
	public void setResultArticleImg(String resultArticleImg) {
		this.resultArticleImg = resultArticleImg;
	}
	public Map<String, Object> getArticleImg() {
		return articleImg;
	}
	public void setArticleImg(Map<String, Object> articleImg) {
		this.articleImg = articleImg;
	}
	
}
