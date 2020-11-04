package project.and.p003.dao;

import java.util.Map;

import project.and.p003.vo.AndP003ChatRoomVO;

public interface AndP003_d001DAO {

	//채팅방 목록 불러오기
	public AndP003ChatRoomVO readChatList(Map<String, Object> chatMap)  throws Exception;

	
}
