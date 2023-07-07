package com.wangscaler.chatmessage.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wangscaler.chatmessage.bean.Message;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author WangScaler
 * @since 2023-07-06
 */
@Mapper
public interface MessageMapper extends BaseMapper<Message> {


}