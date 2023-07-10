package com.wangscaler.chatopenfeign.factory;

import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatopenfeign.clients.RemoteRoomService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@Slf4j
public class RemoteRoomFallbackFactory implements FallbackFactory<RemoteRoomService> {
    @Override
    public RemoteRoomService create(Throwable cause) {
        return new RemoteRoomService() {
            @Override
            public RestResult findAllRoom() {
                return RestResult.error("获取所有房间失败:" + cause.getMessage());
            }

            @Override
            public RestResult findRoomList(List<String> roomList) {
                log.error("获取指定房间列表失败:" + cause.getMessage());
                return RestResult.error("获取指定房间列表失败:" + cause.getMessage());
            }
        };
    }
}
