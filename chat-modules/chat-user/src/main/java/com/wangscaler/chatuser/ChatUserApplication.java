package com.wangscaler.chatuser;

import com.wangscaler.chatcore.annotation.EnableCustomConfig;
import com.wangscaler.chatcore.annotation.EnableRyFeignClients;
import com.wangscaler.chatswagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@EnableCustomConfig
@EnableCustomSwagger2
@EnableRyFeignClients
@SpringBootApplication
public class ChatUserApplication {

    public static void main(String[] args) {
        try {
            SpringApplication.run(ChatUserApplication.class, args);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

}
