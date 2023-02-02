package com.wangscaler.chatroom.bean;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;


/**
 * @Description：房间
 * @Versiion：1.0
 */
@Data
@ApiModel("房间")
@TableName("tb_room")
public class Room {
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
     * 用户ID
     */
    @ApiModelProperty("用户ID")
    private int roomUserId;
    /**
     * 房间号
     */
    @ApiModelProperty("房间号")
    private int roomId;
    /**
     * Logo
     */
    @ApiModelProperty("Logo")
    private String roomLogo;
    /**
     * 房间名
     */
    @ApiModelProperty("房间名")
    private String roomName;
    /**
     * 房间是否需要密码
     *  1:公开
     *  2:加密
     */
    @ApiModelProperty("房间是否需要密码")
    private Integer roomNeedPassword;
    /**
     * 房间密码
     */
    @ApiModelProperty("房间密码")
    private String roomPassword;
    /**
     * 房间公告
     */
    @ApiModelProperty("房间公告")
    private String roomNotice;
    /**
     * 房间背景图片
     */
    @ApiModelProperty("房间背景图片")
    private String roomBgImg;

}
