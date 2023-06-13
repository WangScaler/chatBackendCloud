package com.wangscaler.chatroom;

import com.wangscaler.chatcore.annotation.EnableCustomConfig;
import com.wangscaler.chatswagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@EnableCustomConfig
@EnableCustomSwagger2
@SpringBootApplication
public class ChatRoomApplication {

    public static void main(String[] args) {
        SpringApplication.run(ChatRoomApplication.class, args);
    }

}
