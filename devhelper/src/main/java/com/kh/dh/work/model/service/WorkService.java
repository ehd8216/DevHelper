package com.kh.dh.work.model.service;

import java.util.ArrayList;

import com.kh.dh.common.model.vo.PageInfo;
import com.kh.dh.employmentAPI.model.vo.Scrap;
import com.kh.dh.work.model.vo.Work;



public interface WorkService {
	
	// 채용정보 리스트 페이지 서비스 (페이징)
		int selectListCount();
		ArrayList<Work> selectList(PageInfo pi);
		int scrapinsert(Scrap sc);
		ArrayList<Scrap> scraplist(int memNo);
		// 스크랩 서비스
		int scrapdelete(int sn);

}
