package com.kh.dh.code.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dh.code.model.vo.RoomDTO;

@Repository
public class RoomDao {

	public int insertRoom(SqlSessionTemplate sst, RoomDTO roomDto) {
		return sst.insert("roomMapper.insertRoom", roomDto);
	}
	
	

}
