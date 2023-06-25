package com.wangscaler.chatredis.listener;


import cn.hutool.core.util.ObjectUtil;
import com.wangscaler.chatcore.util.SpringContextUtils;
import org.springframework.stereotype.Component;

import java.util.HashMap;

@Component
public class RedisReceiver {
    /**
     * 接受消息并调用业务逻辑处理器
     *
     * @param params
     */
    public void onMessage(HashMap<String,Object> params) {
        Object handlerName = params.get("handlerName");
        RedisListener messageListener = SpringContextUtils.getHandler(handlerName.toString(), RedisListener.class);
        if (ObjectUtil.isNotEmpty(messageListener)) {
            messageListener.onMessage(params);
        }
    }

}
