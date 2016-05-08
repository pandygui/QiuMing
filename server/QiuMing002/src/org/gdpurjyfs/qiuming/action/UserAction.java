package org.gdpurjyfs.qiuming.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.gdpurjyfs.qiuming.api.WebSocketClient;
import org.gdpurjyfs.qiuming.dao.CommonDao;
import org.gdpurjyfs.qiuming.dao.UserDao;
import org.gdpurjyfs.qiuming.entity.Favorite;
import org.gdpurjyfs.qiuming.entity.Post;
import org.gdpurjyfs.qiuming.entity.User;
import org.gdpurjyfs.qiuming.service.PostService;
import org.gdpurjyfs.qiuming.service.UserService;
import org.gdpurjyfs.qiuming.util.ActionTools;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

@SuppressWarnings("unused")
public class UserAction {

	private UserService userService = new UserService();
	private PostService postService = new PostService();
	
	// 登陆
	// TODO 这里要注意，校验用户登录情况
	public void login(JSONObject action, WebSocketClient client) {
	 System.out.println("action login");
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
	
	// 登出
	public void logout(JSONObject action, WebSocketClient client) {
		System.out.println("action logout");
		User user = client.getUser();

		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("uuid", action.getString("uuid"));

		if (user != null) {
			if (user.getUsername().equals(action.get("username"))) {
				client.setUser(null);
				obj.put("result", "SUCCESS");
			} else {
				obj.put("result", "ERROR");
				obj.put("message", "用户名与服务端不符");
			}
		} else {
			obj.put("result", "ERROR");
			obj.put("message", "用户早已登出");
		}
		client.sendMessage(JSON.toJSONString(obj));
	}
	
	// 获取用户的指定下标开始，size 大的帖子列表
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
			ActionTools.needLogin(action, client);
			return;
		}
		client.sendMessage(JSON.toJSONString(obj));
	}
	
	/**
	 * 获取用户指定收藏夹的所有帖子
	 ***/
	public void getUserFavoriteList(JSONObject action, WebSocketClient client) {
		System.out.println("aciton getUserFavoriteList");
		HashMap<String, Object> obj = new HashMap<String, Object>();
		String favoriteName = action.getString("favoriteName");
		obj.put("uuid", action.getString("uuid"));
		
		if (client.getUser() != null) {
			List<Post> favorites =
					postService.getUserFavoriteList(client.getUser().getId(),
							favoriteName);
			if (favorites != null) {
				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				obj.put("favorites", favorites);
				
			} else {
				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				obj.put("favorites", new ArrayList<Post>());
			}
		} else {			
			ActionTools.needLogin(action, client);
			return;
		}
		client.sendMessage(JSON.toJSONString(obj));
	}	
}
