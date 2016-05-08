package org.gdpurjyfs.qiuming.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.gdpurjyfs.qiuming.api.WebSocketClient;
import org.gdpurjyfs.qiuming.dao.CommonDao;
// import org.gdpurjyfs.qiuming.entity.Post;
import org.gdpurjyfs.qiuming.entity.User;
import org.gdpurjyfs.qiuming.service.FriendService;
import org.gdpurjyfs.qiuming.service.UserService;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class FriendAction {

	private FriendService friendService = new FriendService();
	private UserService userService = new UserService();

	/**
	 * 获取用户关注列表 注意返回的用户中的 password 一定是空的！
	 ***/
	public void getFriendList(JSONObject action, WebSocketClient client) {
		System.out.println("aciton getFriendList");
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("uuid", action.getString("uuid"));

		if (client.getUser() != null) {
			List<User> friends = friendService.getFriendList(client.getUser()
					.getId());
			if (friends != null) {
				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				obj.put("friends", friends);

			} else {
				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				obj.put("friends", new ArrayList<User>());
			}
		} else {
			obj.put("result", "ERROR");
			obj.put("code", "-1");
			obj.put("message", "请登录后操作");
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	/**
	 * 关注某个用户
	 ***/
	public void focusUser(JSONObject action, WebSocketClient client) {
		System.out.println("aciton focusUser");
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("uuid", action.getString("uuid"));

		long focusUserId = action.getLongValue("focusUserId");

		if (client.getUser() != null) {
			// 1. 检查 focusUserId 是否存在
			User focusUser = userService.getUserById(focusUserId);
			if (focusUser != null) {
				String result = friendService.focusUser(client.getUser()
						.getId(), focusUserId);
				obj.put("result", result);
				if (result.equals(CommonDao.SUCCESS)) {
					obj.put("code", "0");
				}
			} else {
				obj.put("code", "-5");
				obj.put("message", "出了一些问题，可能是这个用户不存在吧！");
			}
		} else {
			obj.put("result", "ERROR");
			obj.put("code", "-1");
			obj.put("message", "请登录后操作");
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	/**
	 * 取消关注某个用户
	 ***/
	public void unfocusUser(JSONObject action, WebSocketClient client) {
		System.out.println("aciton unfocusUser");
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("uuid", action.getString("uuid"));

		long focusUserId = action.getLongValue("focusUserId");

		if (client.getUser() != null) {
			// 1. 检查 focusUserId 是否存在
			User focusUser = userService.getUserById(focusUserId);
			if (focusUser != null) {
				String result = friendService.unfocusUser(client.getUser()
						.getId(), focusUserId);
				obj.put("result", result);
				if (result.equals(CommonDao.SUCCESS)) {
					obj.put("code", "0");
				} else if(result.equals(CommonDao.NONE)) {
					obj.put("code", "-1");
					obj.put("message", "你并没有关注过用户，所以无法取消关注哦！");
				}
			} else {
				obj.put("code", "-5");
				obj.put("message", "出了一些问题，可能是这个用户不存在吧！");
			}
		} else {
			obj.put("result", "ERROR");
			obj.put("code", "-1");
			obj.put("message", "请登录后操作");
		}
		client.sendMessage(JSON.toJSONString(obj));
	}
}
