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

- 前端项目改自开源项目[Nine-chat-frontend](https://github.com/longyanjiang/Nine-chat-frontend)

- 后端项目借鉴优秀开源框架[若依](https://github.com/yangzongzhuan/RuoYi-Cloud) 、 [JeecgBoot](https://github.com/jeecgboot/jeecg-boot)

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
|       └── chat-websoket   // websocket[9601]
├──pom.xml                  // 公共依赖
~~~

## 接口文档

接口文档使用swagger。通过网关gateway统一配置，[访问地址](http://localhost:8080/swagger-ui/index.html) 。

## 数据监控

使用druid动态数据源监控数据库信息。[访问地址](http://localhost:9201/druid/login.html) 。

## Nacos

nacos配置mysql的地址，启动nacos将自动拉取mysql的配置文件信息。项目启动时拉取nacos的配置文件。

## Sentinel

sentinel降级熔断的配置信息拉取自nacos

## WebSocket

独立成单个模块

## 构建步骤

默认前提有docker环境

### Nacos配置

修改`docker/nacos/config/application.properties`文件。配置成你自己的数据库信息

### 部署环境

在docker文件夹下执行`docker-compose up`,将成功部署Nacos、MySql、Redis、Sentinel、Senta

### 运行程序

- 运行chat-gateway下的ChatGatewayApplication网关

- 运行chat-room下的ChatRoomApplication聊天室服务

- 运行chat-user下的ChatUserApplication用户服务

- 运行chat-message下的ChatMessageApplication消息服务

- 前端项目请参考[前端文档](./chat-ui/README.md)

### 注意

因为前端项目来自开源项目，需要随着后端的开发逐步整合。

#### 已整合完毕

- 用户模块

    - 注册

    - 登录
    
- 消息模块

    - 集成websocket

    - 完成加入房间提示

    - 完成在线列表显示

    - 完成历史记录的显示

    - 完成在线聊天
    
    - 完成撤回消息
    
    - 完成引用消息
    
- 房间模块

    - 完成在线房间列表

#### 剩余待整合

- 用户模块

    - 更新用户资料
    
    - 用户专属背景
    
    - 后台退出登录
    
- 房间模块
  
    - 创建房间
    
    - 切换房间
    
- 音乐模块
  

### 免责声明

平台音乐数据来源于第三方网站，仅供学习交流使用，请勿用于商业用途，如有侵权联系删除。

### 项目地址

- [github](https://github.com/WangScaler/chatBackendCloud)

- [gitee](https://gitee.com/WangScaler/chatBackendCloud)

- [在线体验](http://chat.dilicili.cn)

### 微信交流群

![](http://chat.dilicili.cn/static/img/wechat.jpg)

