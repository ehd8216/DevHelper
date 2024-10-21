package com.kh.dh.resume.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString

public class Resume {
 private int reNo;
 private int memNo;
 private String reName;
 private String reEmail;
 private String reJobpart;
 private String reintroduce;
 private String reCoverletter;
 private String reSkill;
 private String reRink;
 private String reEducation;
 private String reLiencse;
 private String reStatus;

}
