package com.wangscaler.chatsocket.util;


import cn.hutool.json.JSONObject;
import com.wangscaler.chatcore.constant.WebsocketConst;
import com.wangscaler.chatopenfeign.domain.Message;

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
    //多人消息
    public static JSONObject getMessageData(String id,Integer userId, Object message) throws Exception {
        JSONObject obj = new JSONObject();
        obj.put(WebsocketConst.MSG_TYPE, WebsocketConst.NOTICE_ROOM);
        obj.put(WebsocketConst.MSG_ID, id);
        obj.put(WebsocketConst.MSG_USER_ID,userId.toString());
        obj.put(WebsocketConst.MSG_DATA, message);
        return obj;
    }
    //提示信息
    public static JSONObject getTipData(String id,Integer userId, Object message) throws Exception {
        JSONObject obj = new JSONObject();
        obj.put(WebsocketConst.MSG_TYPE, WebsocketConst.NOTICE_TIP);
        obj.put(WebsocketConst.MSG_ID, id);
        obj.put(WebsocketConst.MSG_USER_ID,userId.toString());
        obj.put(WebsocketConst.MSG_DATA, message);
        return obj;
    }
    //撤回信息
    public static JSONObject getRecallMessageData(String id,Integer userId, Object message) throws Exception {
        JSONObject obj = new JSONObject();
        obj.put(WebsocketConst.MSG_TYPE, WebsocketConst.NOTICE_RECALLMESSAGE);
        obj.put(WebsocketConst.MSG_ID, id);
        obj.put(WebsocketConst.MSG_USER_ID,userId.toString());
        obj.put(WebsocketConst.MSG_DATA, message);
        return obj;
    }

}
