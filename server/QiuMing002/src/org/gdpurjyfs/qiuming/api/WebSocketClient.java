package org.gdpurjyfs.qiuming.api;

import java.io.IOException;

import javax.websocket.Session;

import org.gdpurjyfs.qiuming.entity.User;

public class WebSocketClient {
	
	private Session session;
	private User user;
	
	WebSocketClient(Session session) {
		this.session = session;
	}
	
	WebSocketClient() {
		
	}
	
	public void sendMessage(String message) {
		try {
			this.session.getBasicRemote().sendText(message);
			// this.session.getAsyncRemote().sendText(message);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public Session getSession() {
		return session;
	}
	public void setSession(Session session) {
		this.session = session;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}
