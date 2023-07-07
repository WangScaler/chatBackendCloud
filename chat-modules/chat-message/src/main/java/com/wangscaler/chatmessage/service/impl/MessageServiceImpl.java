package com.wangscaler.chatmessage.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatmessage.bean.Message;
import com.wangscaler.chatmessage.mapper.MessageMapper;
import com.wangscaler.chatmessage.model.MessageUserInfo;
import com.wangscaler.chatmessage.service.MessageService;
import com.wangscaler.chatopenfeign.clients.RemoteUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

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
    @Resource
    private RemoteUserService remoteUserService;

    @Override
    public MessageUserInfo toMessageInfo(Message message) {
        RestResult userInfo = remoteUserService.getAllInfo(Arrays.asList(String.valueOf(message.getUserId())));
        MessageUserInfo messageUserInfo = new MessageUserInfo();
        BeanUtil.copyProperties(message, messageUserInfo);
        List<Object> userInfoData = (List<Object>) userInfo.get("data");
        messageUserInfo.setUserInfo(userInfoData.get(0));
        return messageUserInfo;
    }
}