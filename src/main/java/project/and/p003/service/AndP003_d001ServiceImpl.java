package project.and.p003.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.and.p003.dao.AndP003_d001DAO;
import project.and.p003.vo.AndP003ChatRoomVO;

@Service
public class AndP003_d001ServiceImpl implements AndP003_d001Service{

	@Autowired
	private AndP003_d001DAO andP003_d001DAO;
	
	//채팅방 목록 불러오기
	@Override
	public AndP003ChatRoomVO readChatList(Map<String, Object> chatMap) throws Exception {
		AndP003ChatRoomVO readChatList = null;
		readChatList = andP003_d001DAO.readChatList(chatMap);
		return readChatList;
	}
	
}
