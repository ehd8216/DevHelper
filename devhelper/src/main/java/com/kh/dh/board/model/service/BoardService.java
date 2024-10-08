package com.kh.dh.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.kh.dh.board.model.vo.Board;
import com.kh.dh.board.model.vo.CodeChunk;
import com.kh.dh.common.model.vo.PageInfo;

public interface BoardService {

	int selectListCount(Map<String, Object> conditions);
	ArrayList<Board> selectList(PageInfo pi, Map<String, Object> conditions);
	int insertBoard(Board b);
	int increaseBoardCount(int bNo);
	Board selectBoard(int bNo);
	int insertCodeChunk(String chunk, int chunkOrder);
	ArrayList<CodeChunk> selectCodeChunks(int bNo);
	ArrayList<Board> selectBoardByCount();
	
}
