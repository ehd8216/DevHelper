package com.kh.dh.code.controller;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.OnMessage;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/collab")
public class CollabWebSocket {

	private static final Set<Session> clients = new CopyOnWriteArraySet<>();
	
	@OnMessage
	public void onMessage(String message, Session session) {
		
		for (Session client : clients) {
			
			if (client != session && client.isOpen()) {
				
				try {
					client.getBasicRemote().sendText(message);
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			}
		}
	}
	
	@javax.websocket.OnOpen
	public void onOpen(Session session) {
		clients.add(session);
	}
	
	@javax.websocket.OnClose
	public void onClose(Session session) {
		clients.add(session);
	}
	
}
