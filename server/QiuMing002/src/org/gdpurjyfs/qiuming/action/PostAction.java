package org.gdpurjyfs.qiuming.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.gdpurjyfs.qiuming.api.WebSocketClient;
import org.gdpurjyfs.qiuming.dao.CommonDao;
import org.gdpurjyfs.qiuming.entity.Post;
import org.gdpurjyfs.qiuming.entity.Praise;
import org.gdpurjyfs.qiuming.service.PostService;
import org.gdpurjyfs.qiuming.service.UserService;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class PostAction {
	
	private UserService userService = new UserService();
	private PostService postService = new PostService();
	
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

			if (!result.equals(CommonDao.SUCCESS)) {
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

			if (!result.equals(CommonDao.SUCCESS)) {
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
	
	// 获取全部帖子指定下标开始，size 大的帖子列表
	public void getPostList(JSONObject action, WebSocketClient client) {
		
		long index = action.getLongValue("index");
		long size = action.getLongValue("size");
		
		HashMap<String, Object> obj = new HashMap<String, Object>();
		
		obj.put("uuid", action.getString("uuid"));
		obj.put("result", "SUCCESS");
		obj.put("code", "0");
		
		System.out.println("action getPostList index: "+index+", size:"+size);
		
		List<Post> posts = postService.getPostList(index, size);
		
		obj.put("posts", posts);
		
		System.out.println("action getPostList posts size: "+posts.size());

		client.sendMessage(JSON.toJSONString(obj));
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
			obj.put("pariseNumber", postService.getPostPariseNumber(postId));
		} else {
			obj.put("result", CommonDao.NONE);
			obj.put("postId", 0);
		}
		client.sendMessage(JSON.toJSONString(obj));
	}
}
