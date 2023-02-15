package com.wangscaler.chatopenfeign.factory;

import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatopenfeign.clients.RemoteRoomService;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

@Component
public class RemoteRoomFallbackFactory implements FallbackFactory<RemoteRoomService> {
    @Override
    public RemoteRoomService create(Throwable cause) {
        return new RemoteRoomService() {
            @Override
            public RestResult findAllRoom() {
                return RestResult.error("获取用户失败:" + cause.getMessage());
            }
        };
    }
}
