package com.wangscaler.chatuser.model;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;


/**
 * @Description：用户
 * @Versiion：1.0
 */
@Data
@ApiModel("用户")
public class UserDTO {
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

}
