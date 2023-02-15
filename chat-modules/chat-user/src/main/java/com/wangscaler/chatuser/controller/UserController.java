package com.wangscaler.chatuser.controller;

import cn.hutool.core.date.DateUtil;
import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatuser.bean.User;
import com.wangscaler.chatuser.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

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
public class UserController {
    @Resource
    private UserService userService;

    /**
     * 查询所有的用户
     *
     * @return JSONObject json对象
     */
    @GetMapping(value = "/all")
    public RestResult getUserAllByAdmin() {
        try {
            User user = new User();
            user.setUserPassword("123");
            user.setUserName("98072422");
            user.setUserNick("张三");
            user.setCreatedAt(DateUtil.toLocalDateTime(new Date()));
            user.setUpdatedAt(DateUtil.toLocalDateTime(new Date()));
            user.setUserStatus(1);
            user.setUserSex(1);
            user.setUserEmail("wangsler@163.com");
            user.setUserRole("admin");
            user.setUserSign("没有签名");
            userService.saveUser(user);
            return RestResult.success("新增成功");
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("查询用户失败");
        }
    }

}
