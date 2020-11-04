package project.and.p003.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.and.p003.vo.AndP003ChatRoomVO;

@Repository
public class AndP003_d001DAOImpl implements AndP003_d001DAO{

	@Autowired
	public SqlSession sqlSession;
	
	//채팅방 목록 불러오기
	@Override
	public AndP003ChatRoomVO readChatList(Map<String, Object> chatMap) throws Exception {
		AndP003ChatRoomVO vo = sqlSession.selectOne("and.p003.readChatList",chatMap);
		return vo;
	}

}
