package com.wangscaler.chatsocket.websocket;

import cn.hutool.core.util.ObjectUtil;
import com.wangscaler.chatredis.listener.RedisListener;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;

/**
 * 监听消息(采用redis发布订阅方式发送消息)
 *
 */
@Slf4j
@Component("socketHandler")
public class SocketHandler implements RedisListener {
    @Autowired
    private WebSocket webSocket;
    @Override
    public void onMessage(HashMap<String, Object> map) {
        //TODO 安全校验
        // 禁止用户随意像其他用户发送数据
        try {
            log.info("【SocketHandler消息】Redis Listerer:" + map.toString());
            String userId = String.valueOf(map.get("userId"));
            Object message =  map.get("message");
            if (ObjectUtil.isNotEmpty(userId)) {
                webSocket.pushMessage(userId, message);
            } else {
                webSocket.pushMessage(message);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}