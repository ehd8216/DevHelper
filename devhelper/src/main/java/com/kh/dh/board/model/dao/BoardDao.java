package com.kh.dh.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dh.board.model.vo.Board;
import com.kh.dh.board.model.vo.CodeChunk;
import com.kh.dh.common.model.vo.PageInfo;

@Repository
public class BoardDao {

	public int selectListCount(SqlSessionTemplate sst, Map<String, Object> conditions) {
		return sst.selectOne("boardMapper.selectListCount", conditions);
	}

	public ArrayList<Board> selectList(SqlSessionTemplate sst, PageInfo pi, Map<String, Object> conditions) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sst.selectList("boardMapper.selectList", conditions, rowBounds);
	}

	public int insertBoard(SqlSessionTemplate sst, Board b) {
		return sst.insert("boardMapper.insertBoard", b);
	}

	public int increaseBoardCount(SqlSessionTemplate sst, int bNo) {
		return sst.update("boardMapper.increaseBoardCount", bNo);
	}

	public Board selectBoard(SqlSessionTemplate sst, int bNo) {
		return sst.selectOne("boardMapper.selectBoard", bNo);
	}

	public int insertCodeChunk(SqlSessionTemplate sst, CodeChunk codeChunk) {
		return sst.insert("boardMapper.insertCodeChunk", codeChunk);
	}

	public ArrayList<CodeChunk> selectCodeChunks(SqlSessionTemplate sst, int bNo) {
		return (ArrayList)sst.selectList("boardMapper.selectCodeChunks", bNo);
	}

	public ArrayList<Board> selectBoardByCount(SqlSessionTemplate sst) {
		return (ArrayList)sst.selectList("boardMapper.selectBoardByCount");
	}
	
	public ArrayList<Board> selectBoardByRandom(SqlSessionTemplate sst) {
		return (ArrayList)sst.selectList("boardMapper.selectBoardByRandom");
	}

}
