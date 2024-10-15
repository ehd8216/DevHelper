package com.kh.dh.employmentAPI.model.vo;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Work 
{
	private String instNm;				// 채용기업 이름
	private String recrutPbancTtl;      // 공고제목
	private String pbancEndYmd;         // 공고종료일
	private String ncsCdNmLst;          // 채용분야
	private String hireTypeNmLst;       // 고용형태
	private String replmprYn;           // 대체인력 여부
	private String recrutSeNm;			// 채용구분
	private String workRgnNmLst;        // 근무지
	private String aplyQlfcCn;          // 응시자격
	private String prefCn;				// 우대조건
	private String scrnprcdrMthdExpln;  // 전형절차방법
	
}
