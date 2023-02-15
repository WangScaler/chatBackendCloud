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
     * 新增用户
     *
     * @param user 用户信息
     * @return 结果
     */
    public int saveUser(User user);
}