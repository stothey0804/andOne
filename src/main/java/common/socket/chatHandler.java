package common.socket;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class chatHandler extends TextWebSocketHandler{

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		String payload = message.getPayload();
		TextMessage textMessage = new TextMessage(payload);
		session.sendMessage(textMessage);
	}
}
