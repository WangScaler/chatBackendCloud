package com.wangscaler.chatuser.controller;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.wangscaler.chatcore.util.AESEncryptUtils;
import com.wangscaler.chatcore.util.JWTtokenUtils;
import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatuser.bean.User;
import com.wangscaler.chatuser.model.UserDTO;
import com.wangscaler.chatuser.model.UserInfoDTO;
import com.wangscaler.chatuser.service.UserService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

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
    final private String[] avatarImages = {
            "https://img1.baidu.com/it/u=1738531146,3909274171&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F202004%2F15%2F20200415141655_ihkmq.png&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999"

    };

    /**
     * 注册
     *
     * @return JSONObject json对象
     */
    @PostMapping(value = "/registry")
    @ApiOperation(value = "注册")
    public RestResult registry(@RequestBody UserInfoDTO user) {
        try {
            User userInfo = userService.findOneByUserName(user.getUserName());
            if (ObjectUtil.isNotEmpty(userInfo)) {
                return RestResult.error("账号已存在");
            }
            int sex = RandomUtil.randomInt(1, 2);
            user.setUserAvatar(avatarImages[sex - 1]);
            user.setUserSex(sex);
            user.setUserStatus(1);
            user.setUserPassword(AESEncryptUtils.encrypt(user.getUserPassword()));
            User userNew = ObjectUtil.clone(user);
            userService.save(userNew);
            return RestResult.success("注册成功");
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("注册失败");
        }
    }

    /**
     * 登录
     *
     * @return JSONObject json对象
     */
    @PostMapping(value = "/login")
    @ApiOperation(value = "登录")
    public RestResult login(@RequestBody UserDTO user) {
        try {
            User userInfo = userService.findOneByUserName(user.getUserName());
            userInfo.setUserPassword(AESEncryptUtils.decrypt(userInfo.getUserPassword()));
            if (ObjectUtil.isNotEmpty(userInfo) && user.getUserPassword().equals(userInfo.getUserPassword())) {
                String token = JWTtokenUtils.getToken(userInfo.getId(), userInfo.getUserName(), userInfo.getUserNick(), userInfo.getUserEmail(), userInfo.getUserRole());
                // TODO
                // 将token存在redis中,并设置和token相同的过期时间
                // 从而在网关验证token的合法性
                return RestResult.success("登陆成功", token);
            }
            return RestResult.error("登录失败");
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("登录失败");
        }
    }

    /**
     * 查询所有的用户
     *
     * @return JSONObject json对象
     */
    @GetMapping(value = "/getInfo")
    @ApiOperation(value = "查询所有的用户")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "用户id", required = true, paramType = "query", dataType = "String")})
    public RestResult getInfo(String id) {
        try {
            if (StrUtil.isEmpty(id)) {
                return RestResult.error("参数有误");
            }
            User userInfo = userService.getById(id);
            return RestResult.success(userInfo);
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("登录失败");
        }
    }

}
