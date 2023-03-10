# 聊天室后台微服务版

本系统是聊天室后台的微服务版本，开源且免费使用。

- 前后端分析模式，前端使用vue开发。
- 后端采用Spring Boot、Spring Cloud & Alibaba。
- 注册中心以及服务配置Nacos。
- 网关GateWay
- 负载均衡LoadBalancer
- 服务调用OpenFeign
- 服务降级熔断、流量控制Sentinel
- 分布式事务选型Seata。
## 系统模块

~~~
com.wangscaler     
├── chat-ui                 // 前端框架 [80]
├── chat-gateway            // 网关模块 [8080]
├── chat-openfeign          // 服务调用               
├── chat-common             // 通用模块
│       └── chat-core       // 核心模块
│       └── chat-swagger    // 接口文档
|       └── chat-datasource // 数据源
|       └── chat-seata      // 分布式事务
├── chat-modules            // 业务模块
│       └── chat-user       // 用户模块 [9201]
│       └── chat-room       // 房间模块 [9301]
|       └── chat-message    // 消息模块 [9401]
|       └── chat-music      // 音乐模块 [9501]
├──pom.xml                  // 公共依赖
~~~

## 接口文档

接口文档使用swagger。通过网关gateway统一配置，访问地址http://ip:8080/swagger-ui/index.html

## 数据监控

使用druid动态数据源监控数据库信息。访问地址http://localhost:9201/druid/login.html

## Nacos

nacos配置mysql的地址，启动nacos将自动拉取mysql的配置文件信息。项目启动时拉取nacos的配置文件。

## Sentinel

sentinel降级熔断的配置信息拉取自nacos