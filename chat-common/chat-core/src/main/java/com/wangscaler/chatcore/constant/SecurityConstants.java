package com.wangscaler.chatcore.constant;

/**
 * 权限相关通用常量
 *
 * @author wangscaler
 */
public class SecurityConstants {
    /**
     * 用户ID字段
     */
    public static final String DETAILS_USER_ID = "userId";

    /**
     * 用户名字段
     */
    public static final String DETAILS_USERNAME = "userName";

    /**
     * 角色
     */
    public static final String USER_ROLE = "userRole";
    /**
     * 用户昵称
     */
    public static final String USER_NICK= "userNick";
    /**
     * 邮箱
     */
    public static final String USER_EMAIL = "userEmail";

    /**
     * token过期时间key
     */
    public static final String EXPIRETIME_KEY = "expireTime";

    /**
     * token过期时间
     */
    public static final Integer EXPIRETIME_VALUE = 1000 * 60 * 60 * 24 * 15;

    /**
     * 授权信息字段
     */
    public static final String AUTHORIZATION_HEADER = "Authorization";

    /**
     * 请求来源
     */
    public static final String FROM_SOURCE = "from-source";

    /**
     * 内部请求
     */
    public static final String INNER = "inner";

    /**
     * 用户标识
     */
    public static final String USER_KEY = "userKey";

    /**
     * 登录用户
     */
    public static final String LOGIN_USER = "loginUser";


}
