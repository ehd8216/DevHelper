package com.kh.dh.employmentAPI.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dh.employmentAPI.model.dao.ApiDao;
import com.kh.dh.employmentAPI.model.vo.Scrap;

@Service
public class ApiService 
{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ApiDao Adao;
	
	public int scrapinsert(Scrap scrap)
	{
		return Adao.scrapinsert(sqlSession,scrap); 
	}
}
