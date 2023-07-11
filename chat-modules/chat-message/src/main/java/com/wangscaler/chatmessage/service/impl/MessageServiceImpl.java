package com.wangscaler.chatmessage.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.wangscaler.chatcore.constant.WebsocketConst;
import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatmessage.bean.Message;
import com.wangscaler.chatmessage.mapper.MessageMapper;
import com.wangscaler.chatmessage.model.MessageInfo;
import com.wangscaler.chatmessage.model.QuoteInfo;
import com.wangscaler.chatmessage.service.MessageService;
import com.wangscaler.chatopenfeign.clients.RemoteUserService;
import com.wangscaler.chatopenfeign.domain.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
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
    @Resource
    private MessageMapper messageMapper;

    @Override
    public MessageInfo toMessageInfo(Message message) {
        List<String> userList = new ArrayList<>();
        userList.add(String.valueOf(message.getUserId()));
        Message quoteMessage = null;
        if (ObjectUtil.isNotEmpty(message.getQuoteMessageId())) {
            quoteMessage = messageMapper.selectById(message.getQuoteMessageId());
            if(!userList.contains(String.valueOf(quoteMessage.getUserId()))) {
                userList.add(String.valueOf(quoteMessage.getUserId()));
            }
        }
        RestResult userInfo = remoteUserService.getAllInfo(userList);
        MessageInfo messageUserInfo = new MessageInfo();
        BeanUtil.copyProperties(message, messageUserInfo);
        List<Object> userInfoObject = (List<Object>) userInfo.get("data");
        List<User> userInfoData= new ArrayList<>(userInfoObject.size());
        for (int i = 0; i < userInfoObject.size(); i++) {
            User user = new User();
            BeanUtil.copyProperties(userInfoObject.get(i),user);
            userInfoData.add(user);
        }
        for (int i = 0; i < userInfoData.size(); i++) {
            if(userInfoData.get(i).getId()==message.getUserId()){
                messageUserInfo.setUserInfo(userInfoData.get(i));
            }
            if(ObjectUtil.isNotEmpty(quoteMessage)&&userInfoData.get(i).getId()==quoteMessage.getUserId()){
                QuoteInfo quoteInfo = new QuoteInfo(quoteMessage.getId(),quoteMessage.getMessageStatus(),quoteMessage.getMessageType(),quoteMessage.getMessageContent(),userInfoData.get(i).getUserNick());
                messageUserInfo.setQuoteInfo(quoteInfo);
            }
        }
        if ("-1".equals(message.getMessageStatus())) {
            messageUserInfo.setMessageContent(messageUserInfo.getUserInfo().getUserNick() + "撤回了一条消息哦！");
            messageUserInfo.setMessageType(WebsocketConst.NOTICE_TIP);
        }
        return messageUserInfo;
    }
}