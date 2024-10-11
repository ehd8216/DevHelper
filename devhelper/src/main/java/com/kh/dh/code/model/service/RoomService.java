package com.kh.dh.code.model.service;

import com.kh.dh.code.model.vo.Room;

public interface RoomService {

	int createRoom(Room room);
	Room getRoomById (String roomId);

}
