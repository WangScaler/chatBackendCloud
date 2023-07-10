package com.wangscaler.chatopenfeign.domain;
import lombok.Data;

import java.time.LocalDateTime;


/**
 * @Description：房间
 * @Versiion：1.0
 */
@Data
public class Room {
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
    private int roomUserId;
    /**
     * 房间号
     */
    private int roomId;
    /**
     * Logo
     */
    private String roomLogo;
    /**
     * 房间名
     */
    private String roomName;
    /**
     * 房间是否需要密码
     *  1:公开
     *  2:加密
     */
    private Integer roomNeedPassword;
    /**
     * 房间密码
     */
    private String roomPassword;
    /**
     * 房间公告
     */
    private String roomNotice;
    /**
     * 房间背景图片
     */
    private String roomBgImg;
    /**
     * 房间在线数
     */
    private Integer onLineNums;

}
