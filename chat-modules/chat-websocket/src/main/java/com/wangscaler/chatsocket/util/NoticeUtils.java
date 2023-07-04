package com.wangscaler.chatsocket.util;


import com.alibaba.fastjson2.JSONObject;
import com.wangscaler.chatcore.constant.WebsocketConst;

/**
 */
public class NoticeUtils {
    //系统通知
    public static JSONObject getTopicData(String id, Object message) throws Exception {
        JSONObject obj = new JSONObject();
        obj.put(WebsocketConst.MSG_TYPE, WebsocketConst.NOTICE_TOPIC);
        obj.put(WebsocketConst.MSG_ID, id);
        obj.put(WebsocketConst.MSG_USER_ID,WebsocketConst.SYSTEM_USER);
        obj.put(WebsocketConst.MSG_DATA, message);
        return obj;
    }

}
