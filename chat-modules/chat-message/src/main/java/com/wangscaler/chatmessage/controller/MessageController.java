package com.wangscaler.chatmessage.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.wangscaler.chatcore.util.AESEncryptUtils;
import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatmessage.bean.Message;
import com.wangscaler.chatmessage.model.MessageUserInfo;
import com.wangscaler.chatmessage.service.MessageService;
import com.wangscaler.chatopenfeign.clients.RemoteUserService;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author wangscaler
 * @since 2023-07-06
 */
@RestController
@Slf4j
public class MessageController {
    @Resource
    private MessageService messageService;
    @Autowired
    private RemoteUserService remoteUserService;

    /**
     * 查询历史消息
     *
     * @return JSONObject json对象
     */
    @GetMapping(value = "/history")
    public RestResult<IPage<MessageUserInfo>> getHistoryMessage(Page<Message> page, String roomId) {
        try {
            IPage<Message> messageList = messageService.page(page, new QueryWrapper<Message>().eq("room_id", roomId));
            List<Message> messageResult = messageList.getRecords();
            List<MessageUserInfo> messageUserInfoList = new ArrayList<>(messageResult.size());
            Iterator<Message> iterator = messageResult.iterator();
            while (iterator.hasNext()) {
                Message message = iterator.next();
                MessageUserInfo messageUserInfo = messageService.toMessageInfo(message);
                messageUserInfoList.add(messageUserInfo);
            }
            IPage<MessageUserInfo> messageUserInfoIPage = new Page<MessageUserInfo>();
            BeanUtil.copyProperties(messageList, messageUserInfoIPage);
            messageUserInfoIPage.setRecords(messageUserInfoList);
            return RestResult.success(messageUserInfoIPage);
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("查询历史失败");
        }
    }

    /**
     * 新增消息
     *
     * @return JSONObject json对象
     */
    @PostMapping(value = "/add")
    @ApiOperation(value = "新消息")
    public RestResult add(@RequestBody Message message) {
        try {
            messageService.save(message);
            MessageUserInfo messageUserInfo = messageService.toMessageInfo(messageService.getById(message.getId()));
            return RestResult.success(messageUserInfo);
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("消息保存失败");
        }
    }

}
