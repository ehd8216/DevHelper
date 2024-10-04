package com.kh.dh.member.model.service;

import com.kh.dh.member.model.vo.Member;

public interface MemberService 
{
	int insertMember(Member m);
	Member selectMember(Member m);
}
