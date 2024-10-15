package com.kh.dh.code.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Contest {

	private String name;
	private String id;
    private Date startTime;
    
    public Contest(String name, String id, long startTimeSeconds) {
        this.name = name;
        this.id = id;
        this.startTime = new Date(startTimeSeconds * 1000); // 밀리초로 변환
    }
	
}
