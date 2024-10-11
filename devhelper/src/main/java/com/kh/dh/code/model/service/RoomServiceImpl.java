package com.kh.dh.code.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dh.code.model.dao.RoomDao;
import com.kh.dh.code.model.vo.Room;

@Service
public class RoomServiceImpl implements RoomService {

	@Autowired
	private RoomDao rd;
	
	@Autowired
	private SqlSessionTemplate sst;
	
	@Override
	public int createRoom(Room room) {
		return rd.insertRoom(sst, room);
	}

	@Override
	public Room getRoomById(String roomId) {
		return rd.getRoomById(sst, roomId);
	}

}
