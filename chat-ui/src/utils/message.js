import {getUserId, getRoomId} from '@/utils/auth';
import {enums} from '@/utils/common'

const imgMessageType = ["png", "jpg", "jpeg", "gif", "emo"] // emo 是特殊类型的表情包 也属于图片
const tipsMessageType = ["notice", "info"] // 中间显示的类型 目前有公搞和一些进出切歌房间这类提示
const textMessageType = "text"
/**
 * @desc 封装好发送消息的格式
 * @param {*} userList 发送消息
 */
export const sendMessage = (message, quoteMessage) => {
    var messageInfo = {
        userId: getUserId(),//发送者
        msgId: getUserId(),//暂时无用，随便填写
        roomId: getRoomId(),
        messageType: enums.MessageType.ROOM,//消息类型
        data: {
            userId: getUserId(),
            messageType: textMessageType,
            messageContent: message,//消息
            roomId:getRoomId(),
            quoteUserId : quoteMessage&&quoteMessage.userId?quoteMessage.userId:"",
            quoteMessageId:quoteMessage&&quoteMessage.id?quoteMessage.id:""
        }
    }
    return JSON.stringify(messageInfo)
};
