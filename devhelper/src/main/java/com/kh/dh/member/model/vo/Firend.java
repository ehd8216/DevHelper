package com.kh.dh.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Firend 
{
	private int bfGiver; // 친구 요청자 (닉네임보여줄거임)
	private int bfTaker; // 친구 요청받는자 (닉네임보여줄거임)
	private String fStatus; // 친구 요청 상태
	private String requestDate; // 친구 요청일
}
