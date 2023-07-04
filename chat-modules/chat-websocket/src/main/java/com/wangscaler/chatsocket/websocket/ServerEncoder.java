package com.wangscaler.chatsocket.websocket;
import com.alibaba.fastjson2.JSONObject;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

/**
 * @desc: WebSocket编码器
 * @author: WangScaler
 */
public class ServerEncoder implements Encoder.Text<Object> {

    @Override
    public String encode(Object o) throws EncodeException {
        return JSONObject.toJSONString(o);
    }

    @Override
    public void init(EndpointConfig endpointConfig) {

    }

    @Override
    public void destroy() {

    }
}

