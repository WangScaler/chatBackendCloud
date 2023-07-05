package com.wangscaler.chatopenfeign.factory;

import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatopenfeign.clients.RemoteUserService;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RemoteUserFallbackFactory implements FallbackFactory<RemoteUserService> {
    @Override
    public RemoteUserService create(Throwable cause) {
        return new RemoteUserService() {
            @Override
            public RestResult getInfo() {
                return RestResult.error("获取用户信息失败:" + cause.getMessage());
            }

            @Override
            public RestResult getAllInfo(List<String> userList) {
                return RestResult.error("获取指定用户信息失败:" + cause.getMessage());
            }
        };
    }
}
