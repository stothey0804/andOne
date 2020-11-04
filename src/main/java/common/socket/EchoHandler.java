package common.socket;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


/*
 * @Title	웹소켓 - 알림 핸들러
 * @author	김세영
 * @date	2020. 10. 20.
 * */

public class EchoHandler extends TextWebSocketHandler{
	// 로그인 중 사용자
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1대1
	Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	
	// 클라이언트가 서버로 연결시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String senderId = getMemberId(session);
		if(senderId!=null) {	// 로그인 값이 있는 경우만
			log(senderId + " 연결 됨");
			users.put(senderId, session);
			sessions.add(session);
		}
	}
	
	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String senderId = getMemberId(session);
		//모든 유저에게 보낸다 - 브로드 캐스팅
//		log(senderId+":"+ message.getPayload());
//		for (WebSocketSession sess : sessions) {
//			sess.sendMessage(new TextMessage(message.getPayload()));
//		}
		
		// 특정 유저에게 보내기
		String msg = message.getPayload();
		if(msg != null) {
			String[] strs = msg.split(",");
			log(strs.toString());
			if(strs != null && strs.length == 4) {
//				String cmd = strs[0];	// 삭제 필요할 시 삭제
				String type = strs[0];
				String target = strs[1]; 
				String content = strs[2];
				String url = strs[3];
				WebSocketSession targetSession = users.get(target);  // 타겟세션 조회
				System.out.println("=========targetSession " + targetSession);
				
				// 실시간 접속시
				// 어드민 메시지 받을 때 (분기처리 필요할 경우)
//				if("adminMsg".equals(cmd) && targetSession!=null) {
				if(targetSession!=null) {
					// ex: [&분의일] 신청이 들어왔습니다.
					TextMessage tmpMsg = new TextMessage("<a target='_blank' href='"+ url +"'>[<b>" + type + "</b>] " + content + "</a>" );
					targetSession.sendMessage(tmpMsg);
				}
			}
		}
		
	}
		
	
	// 연결 해제될 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String senderId = getMemberId(session);
		if(senderId!=null) {	// 로그인 값이 있는 경우만
			log(senderId + " 연결 종료됨");
			users.remove(senderId);
			sessions.remove(session);
		}
	}

	// 에러 발생시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());

	}
	
	
	// 로그 메시지
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}
	
	
	// 웹소켓에 id 가져오기
	private String getMemberId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		String m_id = (String) httpSession.get("m_id");
		return m_id==null? null: m_id;
	}
	
	
}
