package org.gdpurjyfs.qiuming.util;

import java.util.HashMap;

import org.gdpurjyfs.qiuming.api.WebSocketClient;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public final class ActionTools {
	
	public static int NEED_LOGIN = -1,
			SUCCESS = 0,
			NONE = 1
			;
	
	// 发送错误信息
	public static void sendError(JSONObject action, WebSocketClient client) {
		HashMap<String, Object> obj = new HashMap<String, Object>();

		obj.put("uuid", action.getString("uuid"));
		obj.put("result", "ERROR");
		obj.put("code", "-1");
		obj.put("message", "没有 action 字段");
		client.sendMessage(JSON.toJSONString(obj));
	}
	
//	public static HashMap<String, Object> getMessageMap(JSONObject action, String result) {
//		HashMap<String, Object> obj = new HashMap<String, Object>();
//		obj.put("uuid",  action.getLongValue("uuid"));
//		obj.put("result", result);
//		return obj;
//	}
	
	public static HashMap<String, Object> getMessageMap(JSONObject action) {
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("uuid",  action.getString("uuid"));
		return obj;
	}
	
	public static void needLogin(JSONObject action, WebSocketClient client) {
		HashMap<String, Object> obj = getMessageMap(action);
		obj.put("message", "请登录后操作");
		obj.put("code", NEED_LOGIN);
		client.sendMessage(JSON.toJSONString(obj));
	}
	
}
