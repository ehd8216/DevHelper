package com.kh.dh.member.model.service;

import java.util.ArrayList;

import com.kh.dh.member.model.vo.Member;

public interface MemberService 
{
	int insertMember(Member m);
	Member selectMember(Member m);
	Member selectMemberDetail(int memNo);
	int updatemember(Member m);
	ArrayList<Member> userlist();
}
