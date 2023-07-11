package com.wangscaler.chatopenfeign.domain;
import lombok.Data;

import java.time.LocalDateTime;


/**
 * @Description：撤回消息
 * @Versiion：1.0
 */
@Data
public class RecallMessage {
    /**
     * 消息Id
     */
    private int messageId;
    /**
     * 用户ID
     */
    private int userId;
    /**
     * 用户昵称
     */
    private String userNick;

    /**
     * 信息
     */
    private String msg;

}
