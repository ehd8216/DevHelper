package com.kh.dh.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dh.member.model.vo.Firend;
import com.kh.dh.member.model.vo.Member;

@Repository
public class MemberDao {
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	
	public Member selectMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.selectMember", m);
	}
	
	public Member selectMemberDetail(SqlSessionTemplate sqlSession, int memNo) {
		return sqlSession.selectOne("memberMapper.selectMemberDetail", memNo);
	}

	public int updatemember(SqlSessionTemplate sqlSession,Member m)
	{
		return sqlSession.update("memberMapper.updatemember", m);
	}
	public ArrayList<Member> userlist(SqlSessionTemplate sqlSession,int memNo)
	{
		return (ArrayList)sqlSession.selectList("memberMapper.userlist",memNo);
	}
	public int friendlist(SqlSessionTemplate sqlSession,Firend f)
	{
		return sqlSession.insert("friendMapper.friendlist", f);
	}
	public int checkFriendExists(SqlSessionTemplate sqlSession,Firend f)
	{
		return sqlSession.selectOne("friendMapper.checkFriendExists", f);
	}
	public List<Map<String, Object>> getReceivedRequests(SqlSessionTemplate sqlSession,int currentMemberId)
	{ 
		return sqlSession.selectList("friendMapper.getReceivedRequests", currentMemberId);
	}
	public List<Map<String, Object>> getSentRequests(SqlSessionTemplate sqlSession,int currentMemberId)
	{
		return sqlSession.selectList("friendMapper.getSentRequests", currentMemberId);
	}
	public int receivefriend(SqlSessionTemplate sqlSession, int memNo, String action, int loginmemNo) 
	{
	        // 파라미터 맵 생성
	        Map<String, Object> parameter = new HashMap();
	        parameter.put("memNo", memNo);
	        parameter.put("loginmemNo", loginmemNo);
	        parameter.put("action", action);
	        
	        // 친구 요청 수락 또는 거절 로직
	      

	        return sqlSession.insert("friendMapper.receivefriend", parameter); 
	 }
	public ArrayList<Member> friendlistselect(SqlSessionTemplate sqlSession, int memNo)
	{
		return (ArrayList)sqlSession.selectList("friendMapper.friendlistselect", memNo);
	}
}
