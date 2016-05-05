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
import org.gdpurjyfs.qiuming.entity.Praise;
import org.gdpurjyfs.qiuming.entity.User;
import org.gdpurjyfs.qiuming.service.PostService;
import org.gdpurjyfs.qiuming.service.UserService;

//import org.junit.Test;

@SuppressWarnings("unused")
public class ActionFilter {

	private UserService userService = new UserService();
	private PostService postService = new PostService();

	// 登陆
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

	// 检查用户是否点赞了某篇帖子
	public void checkUserParisePost(JSONObject action, WebSocketClient client) {
		System.out.println("checkUserParisePost");
		long userId = action.getLongValue("userId");
		long postId = action.getLongValue("postId");
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("uuid", action.getString("uuid"));

		Praise parise = postService.checkUserParisePost(userId, postId);
		if (parise != null) {
			obj.put("result", CommonDao.SUCCESS);
			obj.put("postId", action.getString("postId"));
		} else {
			obj.put("result", CommonDao.NONE);
			obj.put("postId", 0);
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	// 获取指定下标开始，size 大的帖子列表
	public void getUserPostList(JSONObject action, WebSocketClient client) {

		long index = action.getLongValue("index");
		long size = action.getLongValue("size");
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("uuid", action.getString("uuid"));

		if (client.getUser() != null) {
			List<Post> posts = postService.getUserPostList(client.getUser(),
					index, size);
			if (posts != null) {
				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				obj.put("posts", posts);
			} else {
				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				obj.put("posts", new ArrayList<Post>());
			}
		} else {
			obj.put("result", "ERROR");
			obj.put("code", "-1");
			obj.put("message", "请登录后操作");
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	// 创建帖子
	public void createPost(JSONObject action, WebSocketClient client) {
		String title = (String) action.get("title");
		String content = (String) action.get("content");
		HashMap<String, Object> obj = new HashMap<String, Object>();
		
		obj.put("uuid", action.getString("uuid"));
		
		if (client.getUser() != null) {
			String result = postService.createPost(new Post(client.getUser()
					.getId(), title, content));
			if (result.equals(CommonDao.SUCCESS)) {

				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				// TODO 这里要设置
				obj.put("postId", "");
				client.sendMessage(JSON.toJSONString(obj));
				return;
			}
		}
		obj.put("result", "ERROR");
		obj.put("code", "-1");
		obj.put("message", "请登录后操作");
		client.sendMessage(JSON.toJSONString(obj));
	}

	// 取消帖子
	public void unparisePost(JSONObject action, WebSocketClient client) {
		System.out.println("action unparisePost");
		HashMap<String, Object> obj = new HashMap<String, Object>();
		long postId = action.getLongValue("postId");
		obj.put("uuid", action.getString("uuid"));
		obj.put("postId", postId);
		
		if (client.getUser() != null) {

			long userId = client.getUser().getId();
						
			String result = postService.unparisePost(userId, postId);
			obj.put("result", result);
			
			if(!result.equals(CommonDao.SUCCESS)) {
				obj.put("code", "-2");
				obj.put("message", "取消赞失败");
			} 
			
		} else {
			obj.put("result", "ERROR");
			obj.put("code", "-1");
			obj.put("message", "请登录后操作");
		}
		
		obj.put("pariseNumber", postService.getPostPariseNumber(postId));
		client.sendMessage(JSON.toJSONString(obj));
	}

	// 点赞帖子
	public void parisePost(JSONObject action, WebSocketClient client) {
		System.out.println("action parisePost");
		HashMap<String, Object> obj = new HashMap<String, Object>();

		long postId = action.getLongValue("postId");
		obj.put("uuid", action.getString("uuid"));
		obj.put("postId", postId);
		
		if (client.getUser() != null) {
			long userId = client.getUser().getId();
						
			String result = postService.parisePost(userId, postId);
			obj.put("result", result);
			
			if(!result.equals(CommonDao.SUCCESS)) {
				obj.put("code", "-2");
				obj.put("message", "点赞帖子");
			} 
			
		} else {
			obj.put("result", "ERROR");
			obj.put("code", "-1");
			obj.put("message", "请登录后操作");
		}
		
		obj.put("pariseNumber", postService.getPostPariseNumber(postId));
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
		} else if (actionString.equals("checkUserParisePost")) {
			checkUserParisePost(action, client);
		} else if(actionString.equals("parisePost")) {
			parisePost(action, client);
		} else if(actionString.equals("unparisePost")) {
			unparisePost(action, client);
		}
	}

	// 发送错误信息
	private void sendError(JSONObject action, WebSocketClient client) {
		HashMap<String, Object> obj = new HashMap<String, Object>();

		obj.put("uuid", action.getString("uuid"));
		obj.put("result", "ERROR");
		obj.put("code", "-1");
		obj.put("message", "没有 action 字段");
		client.sendMessage(JSON.toJSONString(obj));
	}
}
