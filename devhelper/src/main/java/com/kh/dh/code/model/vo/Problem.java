package com.kh.dh.code.model.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Problem {

	private String name;
	private String contestId;
	private String index;
	private List<String> tags;
	private String rating;
    
}
