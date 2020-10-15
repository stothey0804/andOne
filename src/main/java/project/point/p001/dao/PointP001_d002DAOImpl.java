package project.point.p001.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.point.p001.vo.PointP001VO;

@Repository
public class PointP001_d002DAOImpl implements PointP001_d002DAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int insertPoint(PointP001VO pointVO) {
		return sqlSession.insert("point.p001.insertPoint", pointVO);
	}

}
