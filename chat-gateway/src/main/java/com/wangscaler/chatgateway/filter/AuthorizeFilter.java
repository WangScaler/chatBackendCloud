package com.wangscaler.chatgateway.filter;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.wangscaler.chatcore.constant.SecurityConstants;
import com.wangscaler.chatcore.constant.TokenConstants;
import com.wangscaler.chatcore.util.JWTtokenUtils;
import com.wangscaler.chatcore.util.ServletUtils;
import com.wangscaler.chatcore.util.StringUtils;
import com.wangscaler.chatgateway.properties.IgnoreWhiteProperties;
import io.jsonwebtoken.Claims;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Component
@Slf4j
public class AuthorizeFilter implements GlobalFilter, Ordered {
    // 排除过滤的 uri 地址，nacos自行添加
    @Autowired
    private IgnoreWhiteProperties ignoreWhite;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        ServerHttpRequest request = exchange.getRequest();
        String url = request.getURI().getPath();
        // 跳过不需要验证的路径
        if (StringUtils.matches(url, ignoreWhite.getWhites())) {
            return chain.filter(exchange);
        }
        MultiValueMap<String, String> headers = request.getHeaders();
        String authorization = headers.getFirst(SecurityConstants.AUTHORIZATION_HEADER);
        if (StrUtil.isEmpty(authorization)) {
            return unauthorizedResponse(exchange, "令牌不能为空");
        }
        if (authorization.startsWith(TokenConstants.PREFIX)) {
            Claims claims = JWTtokenUtils.parseToken(JWTtokenUtils.replaceTokenPrefix(authorization));
            if (claims == null) {
                return unauthorizedResponse(exchange, "令牌已过期或验证不正确！");
            }
            // TODO
            // 从redis中验证token的合法性
            return chain.filter(exchange);
        }
        exchange.getResponse().setStatusCode(HttpStatus.UNAUTHORIZED);
        return exchange.getResponse().setComplete();
    }

    private Mono<Void> unauthorizedResponse(ServerWebExchange exchange, String msg) {
        log.error("[鉴权异常处理]请求路径:{}", exchange.getRequest().getPath());
        return ServletUtils.webFluxResponseWriter(exchange.getResponse(), msg, HttpStatus.UNAUTHORIZED.value());
    }

    @Override
    public int getOrder() {
        return -200;
    }
}
