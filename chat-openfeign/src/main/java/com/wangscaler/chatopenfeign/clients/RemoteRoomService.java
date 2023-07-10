package com.wangscaler.chatopenfeign.clients;

import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatopenfeign.factory.RemoteRoomFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@FeignClient(contextId = "remoteRoomService", value = "chat-room", fallbackFactory = RemoteRoomFallbackFactory.class)
public interface RemoteRoomService {
    /**
     * 所有的房间
     *
     * @return 结果
     */
    @GetMapping("/all")
    public RestResult findAllRoom();

    /**
     * 根据id查找房间列表
     *
     * @return 结果
     */
    @PostMapping("/list")
    public RestResult findRoomList(@RequestBody List<String> roomList);
}
