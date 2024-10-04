package com.kh.dh.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dh.board.model.vo.Board;
import com.kh.dh.common.model.vo.PageInfo;

@Repository
public class BoardDao {

	public int selectListCount(SqlSessionTemplate sst) {
		return sst.selectOne("boardMapper.selectListCount");
	}

	public ArrayList<Board> selectList(SqlSessionTemplate sst, PageInfo pi, Integer memNo) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sst.selectList("boardMapper.selectList", memNo, rowBounds);
	}

	public int insertBoard(SqlSessionTemplate sst, Board b) {
		return sst.insert("boardMapper.insertBoard", b);
	}

}
