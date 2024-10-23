package com.kh.dh.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Member {

	private int memNo;
	private String memId;
	private String memToken;
	private String gitNick;
	private String profile;
	private String type;
	private String bio;
	private String memIntro;
	private String stackName;
	private Date createDate;
	private String status;
	private int team;
	private String teamStatus;
	private String proWriter;

	public Member(String gitNick, String profile) {
		this.gitNick = gitNick;
		this.profile = profile;
	}
}
