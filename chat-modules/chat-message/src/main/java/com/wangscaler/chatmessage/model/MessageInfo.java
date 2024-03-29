package com.wangscaler.chatmessage.model;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.wangscaler.chatmessage.bean.Message;
import com.wangscaler.chatopenfeign.domain.User;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;


/**
 * @Description：消息
 * @Versiion：1.0
 */
@Data
public class MessageInfo extends Message {
    /**
     * 用户信息
     */
    private User userInfo;
    /**
     * 引用信息
     */
    private QuoteInfo quoteInfo;


}
