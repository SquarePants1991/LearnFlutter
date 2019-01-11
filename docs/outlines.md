# Dart语言
## 基本语法
  * Best Practices (命名，空格，换行。。。)

## 语法糖
  * 路由注解研究

## 内存管理
  * 大量碎片小内存是否会有性能影响
  * 大内存和小内存的界定
  * 基本类型和复杂类型的深浅拷贝
  * 内存调试方法和工具

## 多线程
  * Future
  * Stream
  * Isolate传值
  * 复杂计算的异步化

## 运行时特性
  * 引用和传值
    * 基本类型还是通过值传递
    * 数组类型是引用
    * 基本类型pass by ref NO！
  * 匿名函数如何捕获变量
    * 基本类型和类都会以引用的方式被方法捕获 (基本类型在赋值和当做参数的时候不会以引用方式传递)
  * 动态类型转换支持，向上，向下，以及无关类型转换
    
  * MIXIN 
    用于代码复用

## 编译时特性
  * 注解
  * 模版支持
  * 重载&覆盖（overload & override）
  * 静态类型转换
  * Macro & Typedef

## 编译器
  * 是否可以支持插件
  * lint相关
  * 编译时长影响因素
  * JIT在调试的时候可能存在的缺陷
  * 是否可以制作HTML2Dart UI Structure parser

# Flutter框架
## UI
  * Material主题和iOS高仿主题学习
  * 布局和重绘基本规则分析
  * 基于Skia的自定义渲染
  * 基于Texture外接纹理的自定义渲染
  * 内置动画和自定义动画
  * 页面路由管理
  * UI组件和State生存周期
  * 基于FlutterPlatformView的平台端view复用

## Network & Json
  * Http，Https，Http2.0的支持
  * Socket支持
  * WebSocket支持
  * Json序列化和反序列化
  * 文件下载，上传

## 持久化 & 文件读写
  * Key-Value持久化
  * 数据库表持久化
  * 文件存储持久化
  * 二进制流处理
  * 大文件处理

## 多媒体
  * 音频录制，播放，剪辑
  * 视频录制，播放，剪辑
  * 图片裁剪（规则和不规则），滤镜，编码存储
  * WebView支持
  * 拍照，图片库
  * Gif，SVG，SVGA支持

## 自定义Flutter库
  * 自定义库编写流程
  * 搭建私有自定义库管理系统

## Platform相关
  * 单Flutter页面集成流程
    * 单App集成指引 https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps
    * 如何集成多个App 
      * 目前目测只能通过单个Flutter App主框架，编写各个业务层代码，由dart层进行业务拆解 (NO NO NO)
      * 每个项目生成自己的App.framework，具体见下面
    * 如何集成通过project形式生成的flutter项目
      * 集成App.framework
    * Native和Flutter页面传参
       * 可以传递initialRouterName
    * 多个Flutter项目如何集成到一个Host中
      * 每个项目的App.framework都是一个bundle，只要bundle identifier不一样，就可以直接通过FlutterDartProject初始化不同的flutter项目，每个App.framework都需要通过embedded framework的方式加入主App
      * 可以通过podspec优化
    * App.framework的调用流程解析
      * https://medium.com/flutter-io/flutters-ios-application-bundle-6f56d4e88cf8 结构分析
      * App.framework主要包含四个部分，dart的aot指令和isolate
    * 需要为每个FlutterViewController注册Plugins
      * FlutterAppDelegate.mm 176行
  * Flutter访问Host项目资源
  * 多个单Flutter页面环境复用
  * 编译后Flutter App包的深入分析
  * 平台相关插件
  * 复用平台的UI控件 (1.0.0似乎提供了更好的方式支持)
    * 使用UIKitView
  * 推送集成
  * app体积
    * App.framework 5.2M Flutter.framework 7.1M 都为动态库 （初始Flutter项目）

## 性能分析 & DEBUG
  * 单页面集成Flutter是否会带来额外的性能负担
  * Widgets Inspector
  https://flutter.io/docs/development/tools/inspector

## 测试
  * 代码单元测试
  * UI单元测试
  * 测试结果友好呈现

## Tips
  * 使用尾部逗号（trailing commas）辅助代码格式化系统进行格式化
  *


# Server端框架