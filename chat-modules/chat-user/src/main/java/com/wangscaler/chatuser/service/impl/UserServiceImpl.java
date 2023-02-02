package com.wangscaler.chatuser.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.wangscaler.chatuser.bean.User;
import com.wangscaler.chatuser.mapper.UserMapper;
import com.wangscaler.chatuser.service.UserService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author WangScaler
 * @since 2023-02-01
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

}