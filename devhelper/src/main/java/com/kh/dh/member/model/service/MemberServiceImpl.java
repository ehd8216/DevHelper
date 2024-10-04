package com.kh.dh.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dh.member.model.dao.MemberDao;
import com.kh.dh.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService 
{
	@Autowired
	private MemberDao mDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertMember(Member m) 
	{
		return mDao.insertMember(sqlSession, m);
	}

	@Override
	public Member selectMember(Member m) 
	{
		return mDao.selectMember(sqlSession, m);
	}

}
