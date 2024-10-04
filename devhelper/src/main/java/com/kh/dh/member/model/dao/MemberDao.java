package com.kh.dh.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dh.member.model.vo.Member;

@Repository
public class MemberDao 
{
	public int insertMember(SqlSessionTemplate sqlSession, Member m)
	{
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	public Member selectMember(SqlSessionTemplate sqlSession, Member m)
	{
		return sqlSession.selectOne("memberMapper.selectMember", m);
	}
}
