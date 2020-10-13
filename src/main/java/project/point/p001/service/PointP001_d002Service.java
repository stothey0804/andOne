package project.point.p001.service;

import project.point.p001.vo.KakaoPayApprovalVO;
import project.point.p001.vo.PointP001VO;

public interface PointP001_d002Service {
	public String kakaoPayReady(String amount);
	public KakaoPayApprovalVO kakaoPayInfo(String pg_token);
	public int insertPoint(PointP001VO pointVO);	// 삽입
	
}
