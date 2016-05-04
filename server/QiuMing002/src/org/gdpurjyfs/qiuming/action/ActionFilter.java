package org.gdpurjyfs.qiuming.action;

import java.io.IOException;
import java.util.HashMap;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import javax.websocket.Session;

import org.gdpurjyfs.qiuming.api.WebSocketClient;
import org.gdpurjyfs.qiuming.api.WebSocketServer;
import org.gdpurjyfs.qiuming.dao.CommonDao;
import org.gdpurjyfs.qiuming.dao.UserDao;
import org.gdpurjyfs.qiuming.entity.User;
import org.gdpurjyfs.qiuming.service.UserService;

//import org.junit.Test;

public class ActionFilter {

	/*
	 * login
	 */

	private UserService service = new UserService();

	public void login(JSONObject action, WebSocketClient client) {
		User user = new User();
		String username = (String) action.get("username");
		String password = (String) action.get("password");
		user.setUsername(username);
		user.setPassword(password);

		String result = service.login(user);

		HashMap<String, Object> obj = new HashMap<String, Object>();

		obj.put("uuid", action.getString("uuid"));
		obj.put("result", result);

		if (result == CommonDao.SUCCESS) {
			obj.put("code", "0");
			User loginUser = service.getUserByName(username);
			client.setUser(loginUser);
			obj.put("user",loginUser);
		} else if (result.equals(CommonDao.NONE)) {
			obj.put("code", "1");
		} else if (result.equals(UserDao.PASSWORD_FAIL)) {
			obj.put("code", "2");
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	// TODO
	public void logout(JSONObject action, WebSocketClient client) {

	}

	public void filter(String message, WebSocketClient client) {
		JSONObject action = JSON.parseObject(message);
		if (action.get("action").equals("login")) {
			login(action, client);
		}
	}
}
