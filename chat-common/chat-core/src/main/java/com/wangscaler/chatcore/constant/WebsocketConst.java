package com.wangscaler.chatcore.constant;

/**
 * @Description: Websocket常量类
 * {
 *     messageType: 消息类型
 *     messageData: 消息数据
 *     msgId: 消息id
 *     userId: 发送者
 * }
 */
public class WebsocketConst {

    /**
     * 消息类型json key:type
     */
    public static final String MSG_TYPE = "messageType";

    /**
     * 消息json key:msgId
     */
    public static final String MSG_ID = "msgId";

    /**
     * 消息内容json key:msgData
     */
    public static final String MSG_DATA = "data";

    /**
     * 消息json key:userId
     */
    public static final String MSG_USER_ID = "userId";

    /**
     * 消息json key:roomId
     */
    public static final String MSG_ROOM_ID = "roomId";

    /**
     * 消息类型 heartcheck
     */
    public static final String NOTICE_CHECK = "heartcheck";

    /**
     * 消息类型 user 单个用户消息
     */
    public static final String NOTICE_USER = "user";
    /**
     * 消息类型 room 群聊消息
     */
    public static final String NOTICE_ROOM = "room";

    /**
     * 消息类型 topic 系统通知
     */
    public static final String NOTICE_TOPIC = "topic";

    /**
     * 系统用户json value:userId
     */
    public static final String SYSTEM_USER = "system";

    /**
     * 消息类型json data:key:type
     */
    public static final String MSG_TIP = "messageTip";
    /**
     * 消息类型json data:key:type
     */
    public static final String ONLINE_USERLIST = "onLineUserList";
    /**
     * 消息类型json data:key:type
     */
    public static final String ROOM_LIST = "roomList";

}
