package com.wangscaler.chatsocket.websocket;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import cn.hutool.json.JSONObject;
import com.wangscaler.chatcore.constant.WebsocketConst;
import com.wangscaler.chatcore.util.JWTtokenUtils;
import com.wangscaler.chatredis.service.RedisService;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
@ServerEndpoint("/conn/{userId}")
public class WebSocket {

    @Autowired
    private RedisService redisService;
    
    private Session session;
    private static final String REDIS_TOPIC_NAME = "socketHandler";
    
    private static CopyOnWriteArraySet<WebSocket> webSockets =new CopyOnWriteArraySet<>();
    private static Map<String,Session> sessionPool = new HashMap<String,Session>();
    
    @OnOpen
    public void onOpen(Session session, @PathParam(value="userId")String userId) {
        try {
			this.session = session;
			webSockets.add(this);
			sessionPool.put(userId, session);
			log.info("【websocket消息】有新的连接，总数为:"+webSockets.size());
		} catch (Exception e) {
		}
    }
    
    @OnClose
    public void onClose() {
        try {
			webSockets.remove(this);
			log.info("【websocket消息】连接断开，总数为:"+webSockets.size());
		} catch (Exception e) {
		}
    }
    
    @OnMessage
    public void onMessage(String message) {
        //todo 现在有个定时任务刷，应该去掉
        log.debug("【websocket消息】收到客户端消息:" + message);
        JSONObject obj = new JSONObject();
        //业务类型
        obj.put(WebsocketConst.MSG_CMD, WebsocketConst.NOTICE_CHECK);
        //消息内容
        obj.put(WebsocketConst.MSG_DATA, "心跳响应");
        for (WebSocket webSocket : webSockets) {
            webSocket.pushMessage(obj);
        }
    }

    /**
     * 服务器端推送消息
     */
    public void pushMessage(Object message) {
        try {
            webSockets.forEach(ws -> ws.session.getAsyncRemote().sendObject(message));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 此为广播消息
    public void sendAllMessage(Object message) {
        log.info("【websocket消息】广播消息:" + message);
        Map<String, Object> hashMap = new HashMap<>();
        hashMap.put("userId", "");
        hashMap.put("message", message);
        hashMap.put("handlerName", REDIS_TOPIC_NAME);
        redisService.convertAndSend("redis_topic", hashMap);
    }
    
    // 此为单点消息
    public void sendOneMessage(String userId, Object message) {
        Map<String, Object> hashMap = new HashMap<>();
        hashMap.put("userId", userId);
        hashMap.put("message", message);
        hashMap.put("handlerName", REDIS_TOPIC_NAME);
        redisService.convertAndSend("redis_topic", hashMap);
    }
    
    // 此为单点消息(多人)
    public void sendMoreMessage(String[] userIds, Object message) {
    	for(String userId:userIds) {
            sendOneMessage(userId, message);
    	}
        
    }
    
}
