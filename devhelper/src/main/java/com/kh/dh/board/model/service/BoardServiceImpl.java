package com.kh.dh.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dh.board.model.dao.BoardDao;
import com.kh.dh.board.model.vo.Board;
import com.kh.dh.board.model.vo.CodeChunk;
import com.kh.dh.common.model.vo.PageInfo;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao bd;
	
	@Autowired
	private SqlSessionTemplate sst;
	
	@Override
	public int selectListCount(Map<String, Object> conditions) {
		return bd.selectListCount(sst, conditions);
	}
	
	@Override
	public ArrayList<Board> selectList(PageInfo pi, Map<String, Object> conditions) {
		return bd.selectList(sst, pi, conditions);
	}

	@Override
	public int insertBoard(Board b) {
		return bd.insertBoard(sst, b);
	}

	@Override
	public int increaseBoardCount(int bNo) {
		return bd.increaseBoardCount(sst, bNo);
	}

	@Override
	public Board selectBoard(int bNo) {
		return bd.selectBoard(sst, bNo);
	}

	@Override
	public int insertCodeChunk(String chunk, int chunkOrder) {
		return bd.insertCodeChunk(sst, new CodeChunk(chunk, chunkOrder));
	}

	@Override
	public ArrayList<CodeChunk> selectCodeChunks(int bNo) {
		return bd.selectCodeChunks(sst, bNo);
	}

	@Override
	public ArrayList<Board> selectBoardByCount() {
		return bd.selectBoardByCount(sst);
	}
	
	@Override
	public ArrayList<Board> selectBoardByRandom() {
		return bd.selectBoardByRandom(sst);
	}

	@Override
	public int deleteBoard(Board b) {
		return bd.deleteBoard(sst, b);
	}


}
