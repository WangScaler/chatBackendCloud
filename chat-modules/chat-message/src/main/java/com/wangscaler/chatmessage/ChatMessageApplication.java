package com.wangscaler.chatmessage;

import com.wangscaler.chatcore.annotation.EnableCustomConfig;
import com.wangscaler.chatcore.annotation.EnableRyFeignClients;
import com.wangscaler.chatswagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@EnableCustomConfig
@EnableCustomSwagger2
@SpringBootApplication
@EnableRyFeignClients
public class ChatMessageApplication {

    public static void main(String[] args) {
        SpringApplication.run(ChatMessageApplication.class, args);
    }

}
