package com.kh.dh.code.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dh.board.model.dao.BoardDao;
import com.kh.dh.code.model.dao.RoomDao;
import com.kh.dh.code.model.vo.Room;
import com.kh.dh.code.model.vo.RoomDTO;

@Service
public class RoomServiceImpl implements RoomService {

	@Autowired
	private RoomDao rd;
	
	@Autowired
	private SqlSessionTemplate sst;
	
	@Override
	public int createRoom(RoomDTO roomDto) {
		
		Room room = new Room();
		room.setRoomName(roomDto.getName());
		room.setRoomPwd(roomDto.getPassword());
		
		return rd.insertRoom(sst, roomDto);
		
	}

}
