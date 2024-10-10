package com.kh.dh.code.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.dh.code.model.service.RoomService;
import com.kh.dh.code.model.vo.RoomDTO;

@Controller
public class CreateRoomController {

	@Autowired
	private RoomService rs;
	
	/*
	@PostMapping("/createRoom")
	public ResponseEntity<?> createRoom(@RequestBody RoomDTO roomDto) {
		System.out.println(roomDto);
		if (roomDto.getName() == null || roomDto.getPassword() == null) {
			return ResponseEntity.badRequest().body("룸 따세요");
		}
		
		int result = rs.createRoom(roomDto);
	
		if (result > 0) {
			return ResponseEntity.status(HttpStatus.CREATED).body("룸 아이디 : " + roomDto.getRoomId());
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("룸 생성에 실패했습니다. 다시 시도해 주세요.");
		}
		
	} */
	
	@ResponseBody
	@RequestMapping(value="/createRoom", produces="json/application; charset=utf-8")
	public String createRoom(RoomDTO roomDto, HttpSession session, HttpServletRequest request) {
		
		int result = 0;
		
		if (roomDto.getName() == null || roomDto.getPassword() == null || roomDto.getName() == "" || roomDto.getPassword() == "") {
			session.setAttribute("warningMsg1", "이름과 비밀번호를 정확히 입력하세요.");
			result = 0;
		} else {
			
			if (rs.createRoom(roomDto) > 0) {
				session.setAttribute("alertMsg1", "룸 아이디는 : " + roomDto.getRoomId() + "입니다.");
				result = 1;
			} else {
				session.setAttribute("errorMsg1", "룸 생성에 실패했습니다.");
				result = 2;
			}
			
		}
		
		return new Gson().toJson(result);
		
	}
	
}
