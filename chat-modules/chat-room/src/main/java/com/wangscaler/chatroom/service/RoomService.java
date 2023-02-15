package com.wangscaler.chatroom.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.wangscaler.chatroom.bean.Room;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author WangScaler
 * @since 2023-02-02
 */
public interface RoomService extends IService<Room> {
    /**
     * 新增房间
     *
     * @param room 房间信息
     * @return 结果
     */
    public int saveRoom(Room room);
}