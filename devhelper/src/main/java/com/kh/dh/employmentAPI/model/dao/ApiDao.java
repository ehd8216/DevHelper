package com.kh.dh.employmentAPI.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dh.employmentAPI.model.vo.Scrap;

@Repository
public class ApiDao 
{
	public int scrapinsert(SqlSessionTemplate sqlSession, Scrap scrap)
	{
		return sqlSession.insert("scrapMapper.scrapinsert", scrap);
	}
}
