package com.wangscaler.chatmessage.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.wangscaler.chatmessage.bean.Message;
import com.wangscaler.chatmessage.mapper.MessageMapper;
import com.wangscaler.chatmessage.service.MessageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author WangScaler
 * @since 2023-07-06
 */
@Service
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message> implements MessageService {

}