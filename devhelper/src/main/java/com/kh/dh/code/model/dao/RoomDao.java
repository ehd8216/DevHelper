package com.kh.dh.code.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dh.code.model.vo.Room;
import com.kh.dh.code.model.vo.RoomDTO;

@Repository
public class RoomDao {

	public int insertRoom(SqlSessionTemplate sst, Room room) {
		return sst.insert("roomMapper.insertRoom", room);
	}

	public Room getRoomById(SqlSessionTemplate sst, String roomId) {
		return sst.selectOne("roomMapper.getRoomById", roomId);
	}
	
	

}
