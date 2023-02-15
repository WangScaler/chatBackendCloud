package com.wangscaler.chatroom.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatroom.bean.Room;
import com.wangscaler.chatroom.service.RoomService;
import io.seata.spring.annotation.GlobalTransactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author wang
 * @since 2023-02-02
 */
@RestController
@Slf4j
public class RoomController {
    @Resource
    private RoomService roomService;

    /**
     * 查询所有的房间
     *
     * @return JSONObject json对象
     */
    @GetMapping(value = "/all")
    public RestResult getRoomAll() {
        try {
            Room room = new Room();
            room.setRoomId(2);
            room.setRoomName("测试");
            roomService.saveRoom(room);
            System.out.println(">>>>>>>>>>>");
            return RestResult.success(room);
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("查询房间失败");
        }
    }

}
