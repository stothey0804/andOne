package project.club.vo;

import org.springframework.stereotype.Component;

@Component
public class ClubArticleImgVO {
	private String resultArticleImg;
	private byte[] articleImg;
	private String cai_id;

	public String getCai_id() {
		return cai_id;
	}
	public void setCai_id(String cai_id) {
		this.cai_id = cai_id;
	}
	public ClubArticleImgVO(){
		System.out.println("gg");
	}
	public byte[] getArticleImg() {
		return articleImg;
	}
	public void setArticleImg(byte[] articleImg) {
		this.articleImg = articleImg;
	}
	public String getResultArticleImg() {
		return resultArticleImg;
	}
	public void setResultArticleImg(String resultArticleImg) {
		this.resultArticleImg = resultArticleImg;
	}
}
