package org.gdpurjyfs.qiuming.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import javax.websocket.Session;

import org.gdpurjyfs.qiuming.api.WebSocketClient;
import org.gdpurjyfs.qiuming.api.WebSocketServer;
import org.gdpurjyfs.qiuming.dao.CommonDao;
import org.gdpurjyfs.qiuming.dao.UserDao;
import org.gdpurjyfs.qiuming.entity.Post;
import org.gdpurjyfs.qiuming.entity.User;
import org.gdpurjyfs.qiuming.service.PostService;
import org.gdpurjyfs.qiuming.service.UserService;

//import org.junit.Test;

@SuppressWarnings("unused")
public class ActionFilter {

	private UserService userService = new UserService();
	private PostService postService = new PostService();

	public void login(JSONObject action, WebSocketClient client) {
		// System.out.println("ActionFilter.login");
		User user = new User();
		String username = (String) action.get("username");
		String password = (String) action.get("password");
		user.setUsername(username);
		user.setPassword(password);

		String result = userService.login(user);

		HashMap<String, Object> obj = new HashMap<String, Object>();

		obj.put("uuid", action.getString("uuid"));
		obj.put("result", result);

		if (result == CommonDao.SUCCESS) {
			obj.put("code", "0");
			User loginUser = userService.getUserByName(username);
			client.setUser(loginUser);
			obj.put("user", loginUser);
		} else if (result.equals(CommonDao.NONE)) {
			obj.put("code", "1");
		} else if (result.equals(UserDao.PASSWORD_FAIL)) {
			obj.put("code", "2");
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	public void enterUserCenter(JSONObject action, WebSocketClient client) {
		if (client.getUser() != null) {

		}
	}

	public void getUserPostList(JSONObject action, WebSocketClient client) {

		long index = action.getLongValue("index");
		long size = action.getLongValue("size");
		HashMap<String, Object> obj = new HashMap<String, Object>();

		if (client.getUser() != null) {
			List<Post> posts = postService.getUserPostList(client.getUser(),
					index, size);
			if (posts != null) {
				obj.put("uuid", action.getString("uuid"));
				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				obj.put("posts", posts);
			} else {
				obj.put("uuid", action.getString("uuid"));
				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				obj.put("posts", new ArrayList<Post>());
			}
		} else {
			obj.put("uuid", action.getString("uuid"));
			obj.put("result", "ERROR");
			obj.put("code", "-1");
			obj.put("message", "请登录后操作");
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	public void createPost(JSONObject action, WebSocketClient client) {
		String title = (String) action.get("title");
		String content = (String) action.get("content");
		HashMap<String, Object> obj = new HashMap<String, Object>();

		if (client.getUser() != null) {
			String result = postService.createPost(new Post(client.getUser()
					.getId(), title, content));
			if (result.equals(CommonDao.SUCCESS)) {
				obj.put("uuid", action.getString("uuid"));
				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				// TODO 这里要设置
				obj.put("postId", "");
				client.sendMessage(JSON.toJSONString(obj));
				return;
			}
		}
		obj.put("uuid", action.getString("uuid"));
		obj.put("result", "ERROR");
		obj.put("code", "-1");
		obj.put("message", "请登录后操作");
		client.sendMessage(JSON.toJSONString(obj));
	}

	// TODO
	public void logout(JSONObject action, WebSocketClient client) {

	}

	public void filter(String message, WebSocketClient client) {
		JSONObject action = JSON.parseObject(message);
		String actionString = (String) action.get("action");
		if (actionString == null) {
			System.out.println("action is null");
			sendError(action, client);
			return;
		}

		if (actionString.equals("login")) {
			login(action, client);
		} else if (actionString.equals("getUserPostList")) {
			getUserPostList(action, client);
		} else if (actionString.equals("createPost")) {
			createPost(action, client);
		}
	}

	private void sendError(JSONObject action, WebSocketClient client) {
		HashMap<String, Object> obj = new HashMap<String, Object>();

		obj.put("uuid", action.getString("uuid"));
		obj.put("result", "ERROR");
		obj.put("code", "-1");
		obj.put("message", "没有 action 字段");
		client.sendMessage(JSON.toJSONString(obj));
	}
}
