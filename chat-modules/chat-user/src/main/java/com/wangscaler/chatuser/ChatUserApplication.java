package com.wangscaler.chatuser;

import com.wangscaler.chatopenfeign.clients.RoomClient;
import com.wangscaler.chatswagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableCustomSwagger2
@EnableFeignClients(clients = {RoomClient.class})
public class ChatUserApplication {

    public static void main(String[] args) {
        SpringApplication.run(ChatUserApplication.class, args);
    }

}
