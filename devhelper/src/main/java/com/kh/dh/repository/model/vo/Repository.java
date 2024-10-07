package com.kh.dh.repository.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Repository {
	
	private String repoName;
	private String repoDescription;
	private String visibility;
	private String createDate;
	private String readMe;
}
