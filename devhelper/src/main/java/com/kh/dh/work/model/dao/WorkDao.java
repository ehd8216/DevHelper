package com.kh.dh.work.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dh.employmentAPI.model.vo.Scrap;

@Repository
public class WorkDao {

	public int selectList(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("workmapper.selectList");
	}
	
	public int scrapinsert(SqlSessionTemplate sqlSession, Scrap sc)
	{
		return sqlSession.insert("scrapMapper.scrapinsert", sc);
	}
	public ArrayList<Scrap> scraplist(SqlSessionTemplate sqlSession, int memNo)
	{
		return (ArrayList)sqlSession.selectList("scrapMapper.scraplist", memNo); 
	}
	public int scrapdelete(SqlSessionTemplate sqlSession, int sn)
	{
		return sqlSession.delete("scrapMapper.scrapdelete", sn);
	}
}
