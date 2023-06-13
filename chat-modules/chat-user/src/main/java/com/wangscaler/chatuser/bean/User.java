package com.wangscaler.chatuser.bean;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;


/**
 * @Description：用户
 * @Versiion：1.0
 */
@Data
@ApiModel("用户")
@TableName("tb_user")
public class User {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    @ApiModelProperty("ID")
    private int id;
    /**
     * 创建时间
     */
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime createdAt;
    /**
     * 更新时间
     */
    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;
    /**
     * 删除时间
     */
    @ApiModelProperty("删除时间")
    private LocalDateTime deletedAt;
    /**
     * 用户名
     */
    @ApiModelProperty("用户名")
    private String userName;
    /**
     * 昵称
     */
    @ApiModelProperty("昵称")
    private String userNick;
    /**
     * 密码
     */
    @ApiModelProperty("密码")
    private String userPassword;
    /**
     * 状态
     */
    @ApiModelProperty("状态")
    private Integer userStatus;
    /**
     * 性别
     */
    @ApiModelProperty("性别")
    private Integer userSex;
    /**
     * 邮箱
     */
    @ApiModelProperty("邮箱")
    private String userEmail;
    /**
     * 头像
     */
    @ApiModelProperty("头像")
    private String userAvatar;
    /**
     * 权限
     */
    @ApiModelProperty("权限")
    private String userRole;
    /**
     * 签名
     */
    @ApiModelProperty("签名")
    private String userSign;
    /**
     * 聊天室背景图
     */
    @ApiModelProperty("聊天室背景图")
    private String userRoomBg;
    /**
     * 房间Id
     */
    @ApiModelProperty("房间Id")
    private String userRoomId;

}
