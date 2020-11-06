package common.socket;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class ChatHandler extends TextWebSocketHandler{
	
	// 로그인 중 사용자
	List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	
	 //클라이언트가 연결 되었을 때 실행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	String senderId = getMemberId(session);
    	users.put(senderId, session);
        sessionList.add(session);
        logger.info("chat-ws // {} 연결됨", "고유 식별자 : " + session.getId() + " // m_id : " + senderId); 
    }

    //클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        logger.info("chat-ws // {}로 부터 {} 받음", session.getId(), message.getPayload());
        String senderId = getMemberId(session);
        JsonParser parser = new JsonParser();
        
        String jsonString = message.getPayload();
        JsonElement element = parser.parse(jsonString);
        
        JsonObject latestMessage = element.getAsJsonObject().get("latestMessage").getAsJsonObject();
        latestMessage.addProperty("m_id", senderId);
        String sendData = latestMessage.toString();
        System.out.println("============================>"+sendData);
        TextMessage result = new TextMessage(sendData);
        
        JsonArray targetList = element.getAsJsonObject().get("userList").getAsJsonArray();
        for(int i=0; i<targetList.size(); i++) {
        	String target = targetList.get(i).getAsString();
        	System.out.println("============================>"+target);
        	WebSocketSession targetSession = users.get(target);
        	if(targetSession!=null) {
				targetSession.sendMessage(result);
				System.out.println("============================>"+target+"에게 데이터 보냄");
			}
        }
    }    
    //클라이언트 연결을 끊었을 때 실행
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	String senderId = getMemberId(session);
    	users.remove(senderId);
        sessionList.remove(session);
        logger.info("chat-ws // {} 연결 끊김.", session.getId());
    }
    
//	@Override
//	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
//		String payload = message.getPayload();
//		TextMessage textMessage = new TextMessage(payload);
//		session.sendMessage(textMessage);
//	}
    
    private String getMemberId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		String m_id = (String) httpSession.get("m_id");
		return m_id==null? null: m_id;
	}
}
