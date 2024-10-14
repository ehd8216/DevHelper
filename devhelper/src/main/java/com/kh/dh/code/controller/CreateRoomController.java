package com.kh.dh.code.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.dh.code.model.service.RoomService;
import com.kh.dh.code.model.vo.Room;

@Controller
public class CreateRoomController {

	@Autowired
	private RoomService rs;
	
	@ResponseBody
	@RequestMapping(value="/createRoom", produces="json/application; charset=utf-8")
	public String createRoom(String name, String password, String language, String access, HttpSession session, HttpServletRequest request) {
		
		String result = "";
		
		if (name == null || password == null || name.equals("") || password.equals("")) {
			session.setAttribute("warningMsg1", "이름과 비밀번호를 정확히 입력하세요.");
			result = "0";
		} else {
			
			Room room = new Room();
			room.setRoomName(name);
			room.setRoomPwd(password);
			room.setLanguage(language);
			room.setAccessibility(access);
			
			if (rs.createRoom(room) > 0) {
			    result = room.getRoomId();
			} else {
				session.setAttribute("errorMsg1", "룸 생성에 실패했습니다.");
				result = "2";
			}
			
		}
		
		return new Gson().toJson(result);
		
	}
	
	@RequestMapping("/{roomId}")
	public String enterRoom(@PathVariable String roomId, Model model, HttpSession session) {
		
		Room room = rs.getRoomById(roomId);
		if (room != null) {
			model.addAttribute("roomId", roomId);
	        model.addAttribute("roomName", room.getRoomName());
	        model.addAttribute("language", room.getLanguage());
			return "community/forum";
		} else {
			session.setAttribute("errorMsg", "no room");
			return "community/community";
		}
		
	}
	
	@ResponseBody
	@RequestMapping("validate.fo")
	public String validateRoom(Room room, HttpSession session) {
		
		Room vroom = rs.getRoomById(room.getRoomId());
		
		if (room.getRoomPwd().equals(vroom.getRoomPwd())) {
			return ""+0;
		} else {
			return ""+1;
		}
  		
	}
	
	@ResponseBody
	@RequestMapping(value="random.ro", produces="application/json; charset=utf-8")
	public String selectRoomByRandom() {
		
		ArrayList<Room> list = rs.selectRoomByRandom();
		
		return new Gson().toJson(list);
		
	}
	
}
