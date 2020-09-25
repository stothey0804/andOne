package common;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class SendSMSTwilio {
	
	  // Find your Account Sid and Token at twilio.com/user/account
	  public static final String ACCOUNT_SID = "ACbad887ed3af9409a0efddd0dc2ee5c0b";
	  public static final String AUTH_TOKEN = "24240d127cf2b2a98c8667c564ec517e";
	  
	  // SMS 전송
	  public static int sendSMS (String phoneNum) {
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
	    
	    // 휴대폰 인증번호 생성
	    int authNum = randomRange(100000, 999999);
	    
	    // 전송대상 휴대폰 번호
	    String sendTarget = "+82" + phoneNum;
	    
	    // 전송 메세지
	    String authMsg = "인증번호를 입력해주세요. [" + authNum + "]" ;
	    
	    
	    Message message = Message.creator(
	    	//To
	    	new PhoneNumber(sendTarget),
	    	//From
	    	new PhoneNumber("00912566855599"), 
	        // message
	    	authMsg).create();
		return authNum;
	  }
	    
	  // 인증번호 범위 지정
	  public static int randomRange(int n1, int n2) {
	    return (int) (Math.random() * (n2 - n1 + 1)) + n1;
	  }
	  
	}