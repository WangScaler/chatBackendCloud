package com.wangscaler.chatuser.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wangscaler.chatuser.bean.User;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author WangScaler
 * @since 2023-02-01
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {


}