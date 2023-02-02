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
├── chat-ui              // 前端框架 [80]
├── chat-gateway         // 网关模块 [8080]
├── chat-openfeign       // 服务调用               
├── chat-common          // 通用模块
│       └── chat-core    // 核心模块
│       └── chat-swagger // 系统接口
├── chat-modules         // 业务模块
│       └── chat-user    // 用户模块 [9201]
│       └── chat-room    // 房间模块 [9300]
├──pom.xml               // 公共依赖
~~~