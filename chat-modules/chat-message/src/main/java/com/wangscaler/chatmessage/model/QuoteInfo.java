package com.wangscaler.chatmessage.model;
import com.wangscaler.chatmessage.bean.Message;
import com.wangscaler.chatopenfeign.domain.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import net.bytebuddy.asm.Advice;


/**
 * @Description：引用消息
 * @Versiion：1.0
 */
@Data
@AllArgsConstructor
public class QuoteInfo {
    /**
     * 消息id
     */
    private Integer quoteMessageId;
    /**
     * 消息状态
     */
    private String quoteMessageStatus;
    /**
     * 消息类型
     */
    private String quoteMessageType;
    /**
     * 消息内容
     */
    private String quoteMessageContent;

    /**
     * 消息发送者昵称
     */
    private String quoteUserNick;

}
