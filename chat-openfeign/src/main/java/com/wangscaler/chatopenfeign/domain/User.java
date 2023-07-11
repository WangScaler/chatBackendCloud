package com.wangscaler.chatopenfeign.domain;
import lombok.Data;

import java.time.LocalDateTime;


/**
 * @Description：用户
 * @Versiion：1.0
 */
@Data
public class User {
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
     * 用户名
     */
    private String userName;
    /**
     * 昵称
     */
    private String userNick;
    /**
     * 密码
     */
    private String userPassword;
    /**
     * 状态
     */
    private Integer userStatus;
    /**
     * 性别
     */
    private Integer userSex;
    /**
     * 邮箱
     */
    private String userEmail;
    /**
     * 头像
     */
    private String userAvatar;
    /**
     * 权限
     */
    private String userRole;
    /**
     * 签名
     */
    private String userSign;
    /**
     * 聊天室背景图
     */
    private String userRoomBg;
    /**
     * 房间Id
     */
    private String userRoomId;

}
