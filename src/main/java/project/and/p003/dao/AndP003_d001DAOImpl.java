package project.and.p003.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.and.p003.vo.AndP003ChatContentVO;
import project.and.p003.vo.AndP003ChatRoomVO;
import project.and.p003.vo.AndP003ChatUserVO;

@Repository
public class AndP003_d001DAOImpl implements AndP003_d001DAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<AndP003ChatRoomVO> getChatRoomList(String m_id) {
		return sqlSession.selectList("and.p003.getChatRoomList",m_id);
	}

	@Override
	public List<AndP003ChatContentVO> getChatContentList(String one_id) {
		return sqlSession.selectList("and.p003.getChatContentList",one_id);
	}

	@Override
	public List<AndP003ChatUserVO> getChatUserList(String one_id) {
		return sqlSession.selectList("and.p003.getChatUserList",one_id);
	}
}
