package com.kh.dh.member.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.dh.member.model.vo.Firend;
import com.kh.dh.member.model.vo.Member;

public interface MemberService 
{
	int insertMember(Member m);
	Member selectMember(Member m);
	Member selectMemberDetail(int memNo);
	int updatemember(Member m);
	ArrayList<Member> userlist();
	int friendlist(Firend f);
	int checkFriendExists(Firend f);
	List<Map<String, Object>> getReceivedRequests(int currentMemberId);
	List<Map<String, Object>> getSentRequests(int currentMemberId);
	int receivefriend(int memNo,String action, int loginmemNo);
}
