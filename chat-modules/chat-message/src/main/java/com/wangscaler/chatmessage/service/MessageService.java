package com.wangscaler.chatmessage.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.wangscaler.chatmessage.bean.Message;
import com.wangscaler.chatmessage.model.MessageUserInfo;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author WangScaler
 * @since 2023-07-06
 */
public interface MessageService extends IService<Message> {
    MessageUserInfo toMessageInfo(Message message);
}