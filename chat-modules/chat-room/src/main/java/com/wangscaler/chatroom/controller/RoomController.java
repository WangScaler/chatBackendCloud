package com.wangscaler.chatroom.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatroom.bean.Room;
import com.wangscaler.chatroom.service.RoomService;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

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
    @ApiOperation(value = "查询房间信息")
    public RestResult getRoomAll() {
        try {
            List<Room> list = roomService.list();
            return RestResult.success(list);
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("查询房间失败");
        }
    }
    /**
     * 查询指定房间列表
     *
     * @return JSONObject json对象
     */
    @PostMapping(value = "/list")
    @ApiOperation(value = "查询所选房间信息")
    public RestResult getRoomAll(@RequestBody List<String> room){
        try {
            List<Room> roomList = roomService.list(new QueryWrapper<Room>().in("room_id",room));
            return RestResult.success(roomList);
        } catch (Exception e) {
            log.error(e.getMessage());
            return RestResult.error("查询房间失败");
        }
    }

}
