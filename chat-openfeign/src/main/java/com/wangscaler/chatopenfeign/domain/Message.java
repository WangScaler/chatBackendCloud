package com.wangscaler.chatopenfeign.domain;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;


/**
 * @Description：消息
 * @Versiion：1.0
 */
@Data
public class Message  {
    /**
     * 主键
     */
    private int id;
    /**
     * 创建时间
     */
    private LocalDateTime createdAt;
    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;
    /**
     * 删除时间
     */
    private LocalDateTime deletedAt;
    /**
     * 用户ID
     */
    private int userId;
    /**
     * 房间号
     */
    private int roomId;
    /**
     * 内容
     */
    private String messageContent;
    /**
     * 消息类型
     */
    private String messageType;
    /**
     * 引用消息人
     */
    private Integer quoteUserId;
    /**
     * 引用的消息ID
     */
    private Integer quoteMessageId;
    /**
     * 消息状态
     *  1: 正常
     *  -1: 已撤回
     */
    private String messageStatus;

}
