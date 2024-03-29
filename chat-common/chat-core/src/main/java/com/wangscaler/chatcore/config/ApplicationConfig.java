package com.wangscaler.chatcore.config;

import com.wangscaler.chatcore.util.SpringContextUtils;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.TimeZone;

/**
 * 系统配置
 *
 * @author wangscaler
 */
@Configuration
public class ApplicationConfig {
    /**
     * 时区配置
     */
    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jacksonObjectMapperCustomization() {
        return jacksonObjectMapperBuilder -> jacksonObjectMapperBuilder.timeZone(TimeZone.getDefault());
    }
    @Bean
    @ConditionalOnMissingBean(SpringContextUtils.class)
    public SpringContextUtils springContextUtils() {
        SpringContextUtils springContext = new SpringContextUtils();
        return springContext;
    }
}