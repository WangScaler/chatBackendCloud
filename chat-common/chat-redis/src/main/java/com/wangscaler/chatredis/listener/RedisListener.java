package com.wangscaler.chatredis.listener;


import java.util.HashMap;

/**
 * @Description: 自定义消息监听
 */
public interface RedisListener {
    /**
     * 接受消息
     *
     * @param message
     */
    void onMessage(HashMap<String,Object> message);

}
