package com.wangscaler.chatmessage.bean;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;


/**
 * @Description：消息
 * @Versiion：1.0
 */
@Data
@ApiModel("消息")
@TableName("tb_message")
public class Message implements Cloneable {
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
    private int userId;
    /**
     * 房间号
     */
    @ApiModelProperty("房间号")
    private int roomId;
    /**
     * 内容
     */
    @ApiModelProperty("内容")
    private String messageContent;
    /**
     * 消息类型
     */
    @ApiModelProperty("消息类型")
    private String messageType;
    /**
     * 引用消息人
     */
    @ApiModelProperty("引用消息人")
    private Integer quoteUserId;
    /**
     * 引用的消息ID
     */
    @ApiModelProperty("引用的消息ID")
    private String quoteMessageId;
    /**
     * 消息状态
     *  1: 正常
     *  -1: 已撤回
     */
    @ApiModelProperty("消息状态")
    private String messageStatus;

    @Override
    public Object clone(){
        Object obj = null;
        try {
            obj = super.clone();
        } catch (CloneNotSupportedException e){
            e.printStackTrace();
        }
        return obj;
    }
}
