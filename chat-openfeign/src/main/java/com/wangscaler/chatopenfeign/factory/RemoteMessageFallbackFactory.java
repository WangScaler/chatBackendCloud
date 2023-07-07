package com.wangscaler.chatopenfeign.factory;

import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatopenfeign.clients.RemoteMessageService;
import com.wangscaler.chatopenfeign.domain.Message;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

@Component
public class RemoteMessageFallbackFactory implements FallbackFactory<RemoteMessageService> {
    @Override
    public RemoteMessageService create(Throwable cause) {
        return new RemoteMessageService() {
            @Override
            public RestResult findAllMessage() {
                return RestResult.error("获取消息失败:" + cause.getMessage());
            }

            @Override
            public RestResult add(Message message) {
                return RestResult.error("新增消息失败:" + cause.getMessage());
            }
        };
    }
}
