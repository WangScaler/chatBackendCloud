package com.wangscaler.chatuser.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.wangscaler.chatuser.bean.User;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author WangScaler
 * @since 2023-02-01
 */
public interface UserService extends IService<User> {
    /**
     * 根据用户名查询用户
     *
     * @param userName 用户名
     * @return 结果
     */
    User findOneByUserName(String userName);
}