package project.root.p003.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.root.p003.vo.RootP003VO;

@Repository
public class RootP003_d001DAOImpl implements RootP003_d001DAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int selectNoticeListCnt() {
		return sqlSession.selectOne("root.p003.selectNoticeListCnt");
	}

	@Override
	public int insertNotice(RootP003VO vo) {
		return sqlSession.insert("root.p003.insertNotice", vo);
	}

	@Override
	public int updateNoticeById(RootP003VO vo) {
		return sqlSession.update("root.p003.updateNoticeById", vo);
	}

	@Override
	public List<RootP003VO> searchNoticeList(Map<String, String> param) {
		return sqlSession.selectList("root.p003.selectNoticeList", param);
	}

	@Override
	public int deleteNoticeById(String n_id) {
		return sqlSession.delete("root.p003.deleteNoticeById", n_id);
	}

	@Override
	public RootP003VO searchNoticeById(String n_id) {
		return sqlSession.selectOne("root.p003.selectNoticeById", n_id);
	}

}
