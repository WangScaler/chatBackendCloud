package com.wangscaler.chatuser.model;
import com.baomidou.mybatisplus.annotation.TableName;
import com.wangscaler.chatuser.bean.User;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;


/**
 * @Description：用户
 * @Versiion：1.0
 */
@Data
@ApiModel("用户")
public class UserInfoDTO extends User implements Cloneable{
    /**
     * 用户名
     */
    @NotEmpty(message = "用户名不能为空")
    @ApiModelProperty("用户名")
    private String userName;
    /**
     * 密码
     */
    @ApiModelProperty("密码")
    @NotEmpty(message = "密码不能为空")
    @Min(value = 6,message = "密码长度最低为6位")
    @Max(value = 30,message = "密码长度最多为30位")
    private String userPassword;
    /**
     * 昵称
     */
    @ApiModelProperty("昵称")
    @NotEmpty(message = "昵称不能为空")
    private String userNick;
    /**
     * 个人签名
     */
    @ApiModelProperty("个人签名")
    private String userSign;
    /**
     * 邮箱
     */
    @ApiModelProperty(value = "邮箱")
    @Email
    private String userEmail;
    /**
     * 头像
     */
    @ApiModelProperty(value = "头像",required = false)
    @Email
    private String userAvatar;
    /**
     * 账号状态
     */
    @ApiModelProperty(value = "账号状态",example = "1(正常)/2(禁用)",required = false)
    private Integer userStatus;
    /**
     * 性别
     */
    @ApiModelProperty(value = "性别",example = "1(正常)/2(禁用)",required = false)
    private Integer userSex;
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
