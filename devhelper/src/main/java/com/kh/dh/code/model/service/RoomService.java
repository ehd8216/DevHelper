package com.kh.dh.code.model.service;

import java.util.ArrayList;

import com.kh.dh.code.model.vo.Room;

public interface RoomService {

	int createRoom(Room room);
	Room getRoomById (String roomId);
	ArrayList<Room> selectRoomByRandom();

}
