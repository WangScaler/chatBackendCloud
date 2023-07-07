package com.wangscaler.chatsocket.util;

import cn.hutool.core.util.IdUtil;
import cn.hutool.extra.spring.SpringUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.wangscaler.chatcore.constant.WebsocketConst;
import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatopenfeign.clients.RemoteMessageService;
import com.wangscaler.chatopenfeign.clients.RemoteUserService;
import com.wangscaler.chatopenfeign.domain.Message;
import com.wangscaler.chatredis.service.RedisService;
import com.wangscaler.chatsocket.websocket.WebSocket;

import javax.websocket.Session;;
import java.util.List;

public class SendMessageUtil {

    /**
     * 静态内部类，延迟加载，懒汉式，线程安全的单例模式
     */
    private static final class Static {
        private static RedisService redisService = SpringUtil.getBean(RedisService.class);
        private static WebSocket webSocket = SpringUtil.getBean(WebSocket.class);
        private static RemoteUserService userService = SpringUtil.getBean(RemoteUserService.class);
        private static RemoteMessageService messageService = SpringUtil.getBean(RemoteMessageService.class);
    }

    /**
     * 发送欢迎加入房间的通知
     *
     * @param allUser 通知列表
     */
    public static void sendJoinUser(String userName, String address, Session session, List<String> allUser) throws Exception {
        String key = IdUtil.fastSimpleUUID();
        String[] userList = allUser.toArray(new String[allUser.size()]);
        JSONObject welcomeMessage = new JSONObject();
        welcomeMessage.put(WebsocketConst.MSG_TIP, new StringBuffer("欢迎").append(userName).append("加入房间!").toString());
        welcomeMessage.put(WebsocketConst.MSG_DATA, new StringBuffer("来自").append(address).append("的").append(userName).append("进入房间了！"));
        welcomeMessage.put(WebsocketConst.ONLINE_USERLIST, Static.userService.getAllInfo(allUser).get(RestResult.DATA_TAG));
        new SendMessageThread(userList, NoticeUtils.getTopicData(key, welcomeMessage)).start();
    }
    /**
     * 发送群聊消息
     *
     * @param allUser 通知列表
     */
    public static void sendRoomMessage(Message message, List<String> allUser) throws Exception {
        String key = IdUtil.fastSimpleUUID();
        String[] userList = allUser.toArray(new String[allUser.size()]);
        RestResult restResult = Static.messageService.add(message);
        new SendMessageThread(userList,NoticeUtils.getMessageData(key,message.getUserId(),restResult.get(RestResult.DATA_TAG))).start();
    }
    /**
     * 发送欢迎加入房间的通知
     * sendJoinUser
     */
    public static class SendMessageThread extends Thread {

        private String[] userList;
        private JSONObject message;

        public SendMessageThread(String[] userList, JSONObject message) {
            this.userList = userList;
            this.message = message;
        }

        @Override
        public void run() {
            Static.webSocket.sendMoreMessage(this.userList, this.message);
        }
    }
}
