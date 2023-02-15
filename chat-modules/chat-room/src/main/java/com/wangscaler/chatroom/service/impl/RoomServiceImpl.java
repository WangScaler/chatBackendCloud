package com.wangscaler.chatroom.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.wangscaler.chatroom.bean.Room;
import com.wangscaler.chatroom.mapper.RoomMapper;
import com.wangscaler.chatroom.service.RoomService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author WangScaler
 * @since 2023-02-02
 */
@Service
public class RoomServiceImpl extends ServiceImpl<RoomMapper, Room> implements RoomService {
    @Resource
    private RoomMapper roomMapper;

    @Override
    public int saveRoom(Room room) {
        return roomMapper.insert(room);
    }
}