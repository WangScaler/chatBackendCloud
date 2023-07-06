package com.wangscaler.chatsocket.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.wangscaler.chatcore.constant.RedisConstants;
import com.wangscaler.chatcore.constant.SecurityConstants;
import com.wangscaler.chatcore.constant.WebsocketConst;
import com.wangscaler.chatcore.util.JWTtokenUtils;
import com.wangscaler.chatredis.service.RedisService;
import com.wangscaler.chatsocket.util.SendMessageUtil;
import io.jsonwebtoken.Claims;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
@ServerEndpoint(value = "/conn", encoders = {ServerEncoder.class})
public class WebSocket {

    @Autowired
    private RedisService redisService;
    /**
     * 用户ID
     */
    private String userId;

    private Session session;
    private static final String REDIS_TOPIC_NAME = "socketHandler";
    /**
     * 记录每个用户的连接session
     */
    private static CopyOnWriteArraySet<WebSocket> webSockets = new CopyOnWriteArraySet<>();
    /**
     * 记录每个用户的连接session
     */
    private static Map<String, Session> sessionPool = new ConcurrentHashMap<String, Session>();
    /**
     * 记录房间中的用户
     */
    private static Map<String, List<String>> roomPool = new ConcurrentHashMap<String, List<String>>();
    /**
     * 记录每个用户和房间的映射关系
     */
    private static Map<String,String> userRoomMap = new ConcurrentHashMap<String, String>();

    @OnOpen
    public void onOpen(Session session) {
        try {
            if (session.getRequestParameterMap().isEmpty()) {
                session.close();
                return;
            }
            List<String> token = session.getRequestParameterMap().get("token");
            Claims claims = JWTtokenUtils.parseToken(token.get(0));
            if (JWTtokenUtils.getUserId(claims).isEmpty()) {
                session.close();
                return;
            }
            String userId = JWTtokenUtils.getUserId(claims);
            this.session = session;
            this.userId = userId;
            webSockets.add(this);
            Session sessionOld = sessionPool.get(this.userId);
            if (sessionOld != null) {
                sessionOld.close();
                log.info("【websocket消息】有新的连接，剔除旧连接");
            }
            sessionPool.put(userId, this.session);
            String address = "中国";
            String roomId = "888";
            if (session.getRequestParameterMap().containsKey("address")) {
                address = session.getRequestParameterMap().get("address").get(0);
            }
            if (session.getRequestParameterMap().containsKey("roomId")) {
                roomId = session.getRequestParameterMap().get("roomId").get(0);
            }
            if (roomPool.isEmpty() || roomPool.get(roomId).isEmpty()) {
                List<String> userList = new ArrayList<>();
                roomPool.put(roomId, userList);
            }
            roomPool.get(roomId).add(userId);
            userRoomMap.put(userId,roomId);
            SendMessageUtil.sendJoinUser(claims.get(SecurityConstants.DETAILS_USERNAME).toString(), address, session, roomPool.get(roomId));
            log.info("【websocket消息】有新的连接，总数为:" + webSockets.size());
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    @OnClose
    public void onClose(Session session) {
        try {
            webSockets.remove(this);
            sessionPool.remove(this.userId);
            String roomId = userRoomMap.get(this.userId);
            roomPool.get(roomId).remove(roomPool.get(roomId).indexOf(this.userId));
            userRoomMap.remove(this.userId);
            log.info("【websocket消息】连接断开，总数为:" + webSockets.size());
        } catch (Exception e) {
        }
    }

    @OnError
    public void onError(Throwable error) {
        System.out.println("onError......"+error.getMessage());
    }
    @SneakyThrows
    @OnMessage
    public void onMessage(String message) {
        JSONObject messageInfo = JSONUtil.parseObj(message);
        if(WebsocketConst.NOTICE_ROOM.equals(messageInfo.get(WebsocketConst.MSG_TYPE))){
            SendMessageUtil.sendRoomMessage(messageInfo, roomPool.get(messageInfo.get(WebsocketConst.MSG_ROOM_ID)));
        }
        JSONObject obj = new JSONObject();
        //业务类型
        obj.put(WebsocketConst.MSG_TYPE, WebsocketConst.NOTICE_CHECK);
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

    /**
     * 服务端推送消息
     *
     * @param userId
     * @param message
     */
    public void pushMessage(String userId, Object message) {
        if (sessionPool.size() > 0) {
            try {
                Session session = sessionPool.get(userId);
                session.getBasicRemote().sendObject(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // 此为广播消息
    public void sendAllMessage(Object message) {
        log.info("【websocket消息】广播消息:" + message);
        Map<String, Object> hashMap = new HashMap<>();
        hashMap.put("userId", "");
        hashMap.put("message", message);
        hashMap.put("handlerName", REDIS_TOPIC_NAME);
        redisService.convertAndSend(RedisConstants.REDIS_WEBSOCKET, hashMap);
    }

    // 此为单点消息
    public void sendOneMessage(String userId, Object message) {
        Map<String, Object> hashMap = new HashMap<>();
        hashMap.put("userId", userId);
        hashMap.put("message", message);
        hashMap.put("handlerName", REDIS_TOPIC_NAME);
        redisService.convertAndSend(RedisConstants.REDIS_WEBSOCKET, hashMap);
    }

    // 此为单点消息(多人)
    public void sendMoreMessage(String[] userIds, Object message) {
        for (String userId : userIds) {
            sendOneMessage(userId, message);
        }

    }
}
