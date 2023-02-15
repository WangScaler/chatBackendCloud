package com.wangscaler.chatopenfeign.clients;

import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatopenfeign.factory.RemoteRoomFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(contextId = "remoteRoomService", value = "chat-room", fallbackFactory = RemoteRoomFallbackFactory.class)
public interface RemoteRoomService {
    /**
     * 发现所有的房间
     *
     * @return 结果
     */
    @GetMapping("/all")
    public RestResult findAllRoom();
}
