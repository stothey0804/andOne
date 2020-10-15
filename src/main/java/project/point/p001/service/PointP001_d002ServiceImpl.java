package project.point.p001.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import project.point.p001.dao.PointP001_d002DAO;
import project.point.p001.vo.KakaoPayApprovalVO;
import project.point.p001.vo.KakaoPayReadyVO;
import project.point.p001.vo.PointP001VO;

@Service
public class PointP001_d002ServiceImpl implements PointP001_d002Service{

	private static final String HOST = "https://kapi.kakao.com";	// HOST URI
	
	private KakaoPayReadyVO kakaoPayReadyVO;
	private KakaoPayApprovalVO kakaoPayApprovalVO;
	
	@Autowired
	private PointP001_d002DAO pointP001_d002DAO;
	
	@Override
	public String kakaoPayReady(String amount) {
		
		RestTemplate restTemplate = new RestTemplate();
		
		// 서버 요청 Header
		HttpHeaders headers = new HttpHeaders();
		String adminKey = "fb3c4c49b51b0686e97dc9baaf3c77f6";
		headers.add("Authorization", "KakaoAK " + adminKey);
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		
		// 서버 요청 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "partner_order_id");		// 
        params.add("partner_user_id", "partner_user_id");	// 
        params.add("item_name", "포인트");
        params.add("quantity", "1");
        params.add("total_amount", amount);		// view에서 받아온 amount
        params.add("tax_free_amount", "0");
        String domain = "http://localhost:8090/";
        params.add("approval_url", domain+"andOne/point/kakaoPaySuccess.do");
        params.add("cancel_url", domain);
        params.add("fail_url", domain);

        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String,String>>(params,headers);
        System.out.println("######### ");
        System.out.println(body.getHeaders());
        System.out.println(body.getBody());
        System.out.println("######### ");
        try {
        	kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
        	System.out.println("" + kakaoPayReadyVO);
        	return kakaoPayReadyVO.getNext_redirect_pc_url();
		} catch (RestClientException  e) {
			e.printStackTrace();
		} catch (URISyntaxException  e) {
			e.printStackTrace();
		}
		return "/";
	}

	@Override
	public KakaoPayApprovalVO kakaoPayInfo(String pg_token) {
        RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
		String adminKey = "fb3c4c49b51b0686e97dc9baaf3c77f6";
		headers.add("Authorization", "KakaoAK " + adminKey);
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
 
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id", "partner_order_id");		// 
        params.add("partner_user_id", "partner_user_id");	// 
        params.add("pg_token", pg_token);
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            return kakaoPayApprovalVO;
        
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return null;
	}

	@Override
	public int insertPoint(PointP001VO pointVO) {
		return pointP001_d002DAO.insertPoint(pointVO);
	}

	
}
