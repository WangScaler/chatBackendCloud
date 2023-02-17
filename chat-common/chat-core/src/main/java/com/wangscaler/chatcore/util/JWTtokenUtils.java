package com.wangscaler.chatcore.util;

import cn.hutool.core.util.IdUtil;
import com.wangscaler.chatcore.constant.TokenConstants;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import com.wangscaler.chatcore.constant.SecurityConstants;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.HashMap;
import java.util.Map;

/**
 * JWTtoken工具类
 *
 * @author wangscaler
 */
public class JWTtokenUtils {
    /**
     * 密匙
     */
    public static String secret = TokenConstants.SECRET;

    /**
     * 加密
     *
     * @param userName token保存的用户名
     * @return token
     */
    public static String getToken(Integer userId, String userName, String userNick, String userEmail, String userRole) {
        Map<String, Object> claims = new HashMap<String, Object>() {
            private static final long serialVersionUID = 1L;

            {
                put(SecurityConstants.USER_KEY, IdUtil.randomUUID());
                put(SecurityConstants.DETAILS_USER_ID, userId);
                put(SecurityConstants.DETAILS_USERNAME, userName);
                put(SecurityConstants.USER_NICK, userNick);
                put(SecurityConstants.USER_EMAIL, userEmail);
                put(SecurityConstants.USER_ROLE, userRole);
                put(SecurityConstants.EXPIRETIME_KEY, System.currentTimeMillis() + SecurityConstants.EXPIRETIME_VALUE);
            }
        };

        String token = Jwts.builder().setClaims(claims).signWith(SignatureAlgorithm.HS512, secret).compact();
        return token;
    }

    /**
     * 从令牌中获取数据声明
     *
     * @param token 令牌
     * @return 数据声明
     */
    public static Claims parseToken(String token) {
        return Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody();
    }
}
