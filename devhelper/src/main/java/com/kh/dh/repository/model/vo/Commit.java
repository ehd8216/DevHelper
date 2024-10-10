package com.kh.dh.repository.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Commit {
	
	private String comAuthor;
	private String comMessage;
	private String comDate;
	private String SHA;

}
