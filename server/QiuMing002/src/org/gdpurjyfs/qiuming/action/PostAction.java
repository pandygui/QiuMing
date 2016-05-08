package org.gdpurjyfs.qiuming.action;

// import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.gdpurjyfs.qiuming.api.WebSocketClient;
import org.gdpurjyfs.qiuming.dao.CommentDao;
import org.gdpurjyfs.qiuming.dao.CommonDao;
import org.gdpurjyfs.qiuming.entity.Favorite;
import org.gdpurjyfs.qiuming.entity.Post;
import org.gdpurjyfs.qiuming.entity.Praise;
import org.gdpurjyfs.qiuming.service.PostService;
import org.gdpurjyfs.qiuming.util.ActionTools;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class PostAction {

	private PostService postService = new PostService();

	/**
	 * 创建帖子
	 ***/
	public void createPost(JSONObject action, WebSocketClient client) {
		String title = (String) action.get("title");
		String content = (String) action.get("content");

		HashMap<String, Object> obj = ActionTools.getMessageMap(action);

		if (client.getUser() != null) {
			String result = postService.createPost(new Post(client.getUser()
					.getId(), title, content));
			if (result.equals(CommonDao.SUCCESS)) {

				obj.put("result", "SUCCESS");
				obj.put("code", "0");
				// TODO 这里要设置
				obj.put("postId", "");
			}
		} else {
			ActionTools.needLogin(action, client);
			return;
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	/**
	 * 取消点赞帖子
	 ***/
	public void unparisePost(JSONObject action, WebSocketClient client) {
		System.out.println("action unparisePost");
		HashMap<String, Object> obj = ActionTools.getMessageMap(action);

		long postId = action.getLongValue("postId");
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
			ActionTools.needLogin(action, client);
			return;
		}

		obj.put("pariseNumber", postService.getPostPariseNumber(postId));
		client.sendMessage(JSON.toJSONString(obj));
	}

	/**
	 * 点赞帖子
	 ***/
	public void parisePost(JSONObject action, WebSocketClient client) {
		System.out.println("action parisePost");

		HashMap<String, Object> obj = ActionTools.getMessageMap(action);

		long postId = action.getLongValue("postId");
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
			ActionTools.needLogin(action, client);
			return;
		}

		obj.put("pariseNumber", postService.getPostPariseNumber(postId));
		client.sendMessage(JSON.toJSONString(obj));
	}

	/**
	 * 获取全部帖子指定下标开始，size 大的帖子列表
	 ***/
	public void getPostList(JSONObject action, WebSocketClient client) {
		System.out.println("action getPostList");
		long index = action.getLongValue("index");
		long size = action.getLongValue("size");

		HashMap<String, Object> obj = ActionTools.getMessageMap(action);
		obj.put("result", "SUCCESS");

		obj.put("code", "0");

		System.out.println("action getPostList index: " + index + ", size:"
				+ size);

		List<Post> posts = postService.getPostList(index, size);

		obj.put("posts", posts);

		System.out.println("action getPostList posts size: " + posts.size());

		client.sendMessage(JSON.toJSONString(obj));
	}

	/**
	 * 检查用户是否点赞了某篇帖子
	 ***/
	public void checkUserParisePost(JSONObject action, WebSocketClient client) {
		System.out.println("checkUserParisePost");
		long userId = action.getLongValue("userId");
		long postId = action.getLongValue("postId");

		HashMap<String, Object> obj = ActionTools.getMessageMap(action);

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

	/**
	 * 收藏帖子
	 ***/
	public void favoritePost(JSONObject action, WebSocketClient client) {
		System.out.println("action favoritePost");

		HashMap<String, Object> obj = ActionTools.getMessageMap(action);

		long postId = action.getLongValue("postId");
		obj.put("postId", postId);

		String favoriteName = action.getString("favoriteName");

		if (client.getUser() != null) {
			long userId = client.getUser().getId();

			String result = postService.favoritePost(userId, postId,
					favoriteName);
			obj.put("result", result);

			if (!result.equals(CommonDao.SUCCESS)) {
				obj.put("code", "-2");
				obj.put("message", "收藏帖子失败");
			}
		} else {
			ActionTools.needLogin(action, client);
			return;
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	/**
	 * 取消收藏帖子
	 ***/
	public void unfavoritePost(JSONObject action, WebSocketClient client) {
		System.out.println("action unfavoritePost");

		HashMap<String, Object> obj = ActionTools.getMessageMap(action);

		long postId = action.getLongValue("postId");
		obj.put("postId", postId);

		String favoriteName = action.getString("favoriteName");

		if (client.getUser() != null) {
			long userId = client.getUser().getId();

			String result = postService.unfavoritePost(userId, postId,
					favoriteName);
			obj.put("result", result);

			if (!result.equals(CommonDao.SUCCESS)) {
				obj.put("code", "-2");
				obj.put("message", "取消收藏帖子失败");
			}
		} else {
			ActionTools.needLogin(action, client);
			return;
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	/**
	 * 检查用户是否收藏此篇帖子
	 ***/
	public void checkUserFavoritePost(JSONObject action, WebSocketClient client) {
		System.out.println("action checkUserFavoritePost");

		HashMap<String, Object> obj = ActionTools.getMessageMap(action);

		long userId = action.getLongValue("userId");
		long postId = action.getLongValue("postId");
		String favoriteName = action.getString("favoriteName");

		Favorite favorite = postService.checkUserFavoritePost(userId, postId,
				favoriteName);
		if (favorite != null) {
			obj.put("result", CommonDao.SUCCESS);
			obj.put("postId", action.getString("postId"));
			obj.put("favoriteName", favoriteName);
		} else {
			obj.put("result", CommonDao.NONE);
			obj.put("postId", 0);
		}
		client.sendMessage(JSON.toJSONString(obj));
	}

	/**
	 * 更新帖子
	 ***/
	public void modifyPost(JSONObject action, WebSocketClient client) {
		// postId , title, content
		System.out.println("action modifyPost");
		HashMap<String, Object> obj = ActionTools.getMessageMap(action);

		long postId = action.getLongValue("postId");
		String title = action.getString("title");
		String content = action.getString("content");
		long userId = action.getLongValue("userId");

		if (client.getUser() != null) {
			
			if(userId == client.getUser().getId()) {
				String result = postService.modifyPost(new Post(client.getUser().getId(), postId,
						title, content));
				obj.put("result", result);
				if(result.equals(CommonDao.SUCCESS)) {
					obj.put("code", 0);
					client.sendMessage(JSON.toJSONString(obj));
				} else if(result.equals(CommonDao.NONE)) {
					obj.put("code", -1);
					obj.put("message", "没有这篇文章");
					client.sendMessage(JSON.toJSONString(obj));
				} else {
					obj.put("code", -2);
					obj.put("message", "未知错误");
					client.sendMessage(JSON.toJSONString(obj));
				}
			} else {
				ActionTools.needLogin(action, client);
			}
		} else {
			ActionTools.needLogin(action, client);
		}
	}
	
	/**
	 * 举报帖子
	 ***/
	public void complainPost(JSONObject action, WebSocketClient client) {
		// postId , title, content
		System.out.println("action complainPost");
		HashMap<String, Object> obj = ActionTools.getMessageMap(action);
		
		long postId = action.getLongValue("postId");
		String reason = action.getString("reason");
		
		if (client.getUser() != null) {
			String result = postService.complainPost(client.getUser().getId(),
					postId, reason);
			obj.put("result", result);
			if(result.equals(CommonDao.SUCCESS)) {
				obj.put("code", 0);
				
				// TODO 发送私信
				
			} else if(result.equals(CommentDao.DUPLICATE)) {
				obj.put("code", -2);
				obj.put("message","重复举报");
			} else {
				obj.put("code", -1);
				obj.put("message","举报失败");
			}
			client.sendMessage(JSON.toJSONString(obj));
		} else {
			ActionTools.needLogin(action, client);
		}
	}
}
