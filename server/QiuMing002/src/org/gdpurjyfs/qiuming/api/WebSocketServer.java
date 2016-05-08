package org.gdpurjyfs.qiuming.api;

// import java.io.IOException;
import java.util.HashMap;
import java.util.concurrent.CopyOnWriteArraySet;

// import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.gdpurjyfs.qiuming.action.ActionFilter;

@SuppressWarnings("unused")
@ServerEndpoint("/websocket")
public class WebSocketServer {
	// 静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
	private static int onlineCount = 0;

	// concurrent包的线程安全Set，用来存放每个客户端对应的 WebSocketClient 对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中 Key 可以为用户标识
	// private static CopyOnWriteArraySet<WebSocketClient> webSocketClientSet = new CopyOnWriteArraySet<WebSocketClient>();
	
	// sessionId Client
	private static HashMap<String, WebSocketClient> userMap = new HashMap<String, WebSocketClient>(); 

	// 一般是一个连接一个 WebSocketServer 实例
	public WebSocketServer() {
		// System.out.println("WebSocketServer()...");
	}
	
	/**
	 * 连接建立成功调用的方法
	 * 
	 * @param session 可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
	 */
	@OnOpen
	public void onOpen(Session session) {
		
		// webSocketClientSet.add(new WebSocketClient(session));		
		// userMap.put(session.getId(), new WebSocketClient(session));
		addClient(session.getId(), new WebSocketClient(session));

		addOnlineCount(); // 在线数加1
		// System.out.println("有新连接加入！当前在线人数为" + getOnlineCount());
	}

	/**
	 * 连接关闭调用的方法
	 */
    @OnClose  
    public void onClose(Session peer) {  
    	// webSocketClientSet.remove(peer);
    	// userMap.remove(peer.getId());
    	
    	removeClient(peer.getId());
    	
    	subOnlineCount(); // 在线数减1
		// System.out.println("有一连接关闭！当前在线人数为" + getOnlineCount());
    }  

	/**
	 * 收到客户端消息后调用的方法
	 * 
	 * @param message 客户端发送过来的消息
	 * @param session 可选的参数
	 */
	@OnMessage
	public void onMessage(String message, Session session) {
		// System.out.println("来自客户端的消息:" + message);
		
		// 响应客户端发送的 action 
		ActionFilter filter = new ActionFilter();
		filter.filter(this, message, userMap.get(session.getId()));
		
//		// 群发消息
//		for (WebSocketClient item : webSocketClientSet) {
//			try {
//				item.sendMessage(item.getSession().getId() + ": " + message);
//			} catch (IOException e) {
//				e.printStackTrace();
//				continue;
//			}
//		}
		
	}

	/**
	 * 发生错误时调用
	 * 
	 * @param session
	 * @param error
	 */
	@OnError
	public void onError(Session session, Throwable error) {
		System.out.println("发生错误");
	    error.printStackTrace();
	}
	
	public static synchronized int getOnlineCount() {
		return onlineCount;
	}

	public static synchronized void addOnlineCount() {
		WebSocketServer.onlineCount++;
	}

	public static synchronized void subOnlineCount() {
		WebSocketServer.onlineCount--;
	}
	
	public static synchronized void addClient(String userId, WebSocketClient client) {
		userMap.put(userId , client);
	}
	
	public static synchronized void removeClient(String userId) {
		userMap.remove(userId);
	}
}
