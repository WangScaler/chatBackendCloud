package com.wangscaler.chatdatasource.config;

import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * mybatis-plus配置
 *
 * @author wangscaler
 * @date 2023/07/11
 */
@Configuration
public class MybatisConfig {


    /**
     * 分页插件
     */
    @Bean
    public PaginationInterceptor paginationInterceptor() {
        PaginationInterceptor  paginationInterceptor = new PaginationInterceptor ();
        paginationInterceptor.setDialectType("mysql");
        return paginationInterceptor;
    }

}
