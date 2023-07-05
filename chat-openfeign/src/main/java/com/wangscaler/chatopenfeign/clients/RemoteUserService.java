package com.wangscaler.chatopenfeign.clients;

import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatopenfeign.factory.RemoteUserFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@FeignClient(contextId = "remoteUserService", value = "chat-user", fallbackFactory = RemoteUserFallbackFactory.class)
public interface RemoteUserService {
    /**
     * 查询用户的信息
     *
     * @return 结果
     */
    @GetMapping("/getInfo")
    public RestResult getInfo();

    /**
     * 查询所选用户的信息
     *
     * @return 结果
     */
    @PostMapping("/getAllInfo")
    public RestResult getAllInfo(@RequestBody List<String> userList);
}
