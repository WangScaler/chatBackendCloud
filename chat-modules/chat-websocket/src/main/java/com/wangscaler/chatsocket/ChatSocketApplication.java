package com.wangscaler.chatsocket;
import com.wangscaler.chatcore.annotation.EnableCustomConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@EnableCustomConfig
@SpringBootApplication
public class ChatSocketApplication {

    public static void main(String[] args) {
        try {
            SpringApplication.run(ChatSocketApplication.class, args);
        } catch (Exception e) {
            System.out.println(e);
        }
    }

}
