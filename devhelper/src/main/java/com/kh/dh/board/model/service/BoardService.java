package com.kh.dh.board.model.service;

import java.util.ArrayList;

import com.kh.dh.board.model.vo.Board;
import com.kh.dh.common.model.vo.PageInfo;

public interface BoardService {

	int selectListCount();
	ArrayList<Board> selectList(PageInfo pi, Integer mNo);
	int insertBoard(Board b);
}
