package com.wangscaler.chatuser.controller;

import com.wangscaler.chatcore.web.domain.RestResult;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.wangscaler.chatopenfeign.clients.RoomClient;
import com.wangscaler.chatuser.bean.User;
import com.wangscaler.chatuser.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author WangScaler
 * @since 2023-02-01
 */
@RestController
@Slf4j
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;
    @Autowired
    private RoomClient roomClient;

    /**
     * 查询所有的用户
     *
     * @return JSONObject json对象
     */
    @GetMapping(value = "/all")
    public RestResult getUserAllByAdmin(Page<User> page) {
        try {
            IPage<User> userList = userService.page(page);
            RestResult room = roomClient.findAllRoom();
            return room;
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("查询用户失败");
        }
    }

}
