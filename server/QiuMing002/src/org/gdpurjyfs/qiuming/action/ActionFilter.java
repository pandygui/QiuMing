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
import org.gdpurjyfs.qiuming.util.ActionTools;

//import org.junit.Test;

@SuppressWarnings("unused")
public class ActionFilter {

	private UserAction userAction = new UserAction();
	private PostAction postAction = new PostAction();
	private FriendAction friendAction = new FriendAction();
	
	public void filter(WebSocketServer server, String message,
			WebSocketClient client) {

		JSONObject action = JSON.parseObject(message);
		String actionString = (String) action.get("action");
		if (actionString == null) {
			System.out.println("action is null");
			ActionTools.sendError(action, client);
		} else if (actionString.equals("login")) {
			userAction.login(action, client);
		} else if (actionString.equals("logout")) {
			userAction.logout(action, client);
		} else if (actionString.equals("getUserPostList")) {
			userAction.getUserPostList(action, client);
		} else if (actionString.equals("createPost")) {
			postAction.createPost(action, client);
		} else if (actionString.equals("modifyPost")) {
			postAction.modifyPost(action, client);
		} else if (actionString.equals("complainPost")) {
			postAction.complainPost(action, client);
		}  else if (actionString.equals("checkUserParisePost")) {
			postAction.checkUserParisePost(action, client);
		} else if (actionString.equals("parisePost")) {
			postAction.parisePost(action, client);
		} else if (actionString.equals("unparisePost")) {
			postAction.unparisePost(action, client);
		} else if(actionString.equals("getPostList")) {
			postAction.getPostList(action, client);
		} else if(actionString.equals("unfavoritePost")) {
			postAction.unfavoritePost(action, client);
		} else if(actionString.equals("checkUserFavoritePost")) {
			postAction.checkUserFavoritePost(action, client); 
		} else if(actionString.equals("favoritePost")) {
			postAction.favoritePost(action, client); 
		} else if(actionString.equals("getUserFavoriteList")) {
			userAction.getUserFavoriteList(action, client); 
		} else if(actionString.equals("getFriendList")) {
			friendAction.getFriendList(action, client); 
		} 
	}
}
