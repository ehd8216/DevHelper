package com.kh.dh.member.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dh.member.model.dao.MemberDao;
import com.kh.dh.member.model.vo.Firend;
import com.kh.dh.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
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

	@Override
	public Member selectMemberDetail(int memNo) {

		return mDao.selectMemberDetail(sqlSession, memNo);
	}

	@Override
	public int updatemember(Member m) 
	{
		return mDao.updatemember(sqlSession,m);
	}

	@Override
	public ArrayList<Member> userlist(int memNo) {
		return mDao.userlist(sqlSession,memNo);
	}

	@Override
	public int friendlist(Firend f)
	{
		return mDao.friendlist(sqlSession,f);
	}

	@Override
	public int checkFriendExists(Firend f)
	{
		return mDao.checkFriendExists(sqlSession,f);
	}

	@Override
	public List<Map<String, Object>> getReceivedRequests(int currentMemberId)
	{
		return mDao.getReceivedRequests(sqlSession,currentMemberId);
	}

	@Override
	public List<Map<String, Object>> getSentRequests(int currentMemberId)
	{
		return mDao.getSentRequests(sqlSession,currentMemberId);
	}

	@Override
	public int receivefriend(int memNo, String action,int loginmemNo) 
	{
		return mDao.receivefriend(sqlSession,memNo,action,loginmemNo);
	}

	@Override
	public ArrayList<Member> friendlistselect(int memNo) 
	{
		return mDao.friendlistselect(sqlSession,memNo);
	}

}
