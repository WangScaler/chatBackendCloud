package com.wangscaler.chatmessage.controller;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatmessage.bean.Message;
import com.wangscaler.chatmessage.model.MessageInfo;
import com.wangscaler.chatmessage.service.MessageService;
import com.wangscaler.chatopenfeign.clients.RemoteUserService;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.ArrayList;
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

    /**
     * 查询历史消息
     *
     * @return JSONObject json对象
     */
    @GetMapping(value = "/history")
    public RestResult<IPage<MessageInfo>> getHistoryMessage(Page<Message> page, String roomId) {
        try {
            IPage<Message> messageList = messageService.page(page, new QueryWrapper<Message>().eq("room_id", roomId));
            List<Message> messageResult = messageList.getRecords();
            List<MessageInfo> messageUserInfoList = new ArrayList<>(messageResult.size());
            Iterator<Message> iterator = messageResult.iterator();
            while (iterator.hasNext()) {
                Message message = iterator.next();
                MessageInfo messageInfo = messageService.toMessageInfo(message);
                messageUserInfoList.add(messageInfo);
            }
            IPage<MessageInfo> messageUserInfoIPage = new Page<MessageInfo>();
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
            MessageInfo messageUserInfo = messageService.toMessageInfo(messageService.getById(message.getId()));
            return RestResult.success(messageUserInfo);
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("消息保存失败");
        }
    }

    /**
     * 根据id查询消息信息
     *
     * @return JSONObject json对象
     */
    @GetMapping(value = "/findOne")
    @ApiOperation(value = "修改消息")
    public RestResult getMessageById(@RequestParam("id")String id) {
        try {
            Message message = messageService.getById(id);
            return RestResult.success(message);
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("查询历史失败");
        }
    }
    /**
     * 修改消息
     *
     * @return JSONObject json对象
     */
    @PostMapping(value = "/update")
    @ApiOperation(value = "修改消息")
    public RestResult update(@RequestBody Message message) {
        try {
            message.setUpdatedAt(LocalDateTime.now());
            message.setMessageStatus("-1");
            messageService.saveOrUpdate(message);
            return RestResult.success("修改成功");
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("消息保存失败");
        }
    }
}
