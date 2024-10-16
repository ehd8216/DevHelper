package com.kh.dh.work.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dh.common.model.vo.PageInfo;
import com.kh.dh.employmentAPI.model.vo.Scrap;
import com.kh.dh.work.model.dao.WorkDao;
import com.kh.dh.work.model.vo.Work;


@Service
public class WorkServiceImpl implements WorkService{
	
	@Autowired
	private WorkDao wDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount() {
		return wDao.selectList(sqlSession);
	}

	@Override
	public ArrayList<Work> selectList(PageInfo pi) {
		
		return null;
	}

	@Override
	public int scrapinsert(Scrap sc) { 
		return wDao.scrapinsert(sqlSession,sc); 
	}

	@Override
	public ArrayList<Scrap> scraplist(int memNo) {
		return wDao.scraplist(sqlSession, memNo);
	}
	
	
	

}
