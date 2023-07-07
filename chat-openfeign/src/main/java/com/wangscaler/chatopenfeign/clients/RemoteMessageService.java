package com.wangscaler.chatopenfeign.clients;

import com.wangscaler.chatcore.web.domain.RestResult;
import com.wangscaler.chatopenfeign.domain.Message;
import com.wangscaler.chatopenfeign.factory.RemoteMessageFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(contextId = "remoteMessageService", value = "chat-message", fallbackFactory = RemoteMessageFallbackFactory.class)
public interface RemoteMessageService {
    /**
     * 获取历史消息
     *
     * @return 结果
     */
    @GetMapping("/all")
    public RestResult findAllMessage();

    /**
     * 新增消息
     *
     * @return JSONObject json对象
     */
    @PostMapping(value = "/add")
    public RestResult add(@RequestBody Message message);
}
