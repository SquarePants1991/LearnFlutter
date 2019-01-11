# Release模式的接入
Release下主要有三个产物
* Flutter.framework
* App.framework
* flutter_assets

Flutter.framework可以永久嵌入Host App
不同Flutter项目的App.framework需要赋予不同的bundle identifier，然后通过一定的方式嵌入Host App
flutter_assets需要跟随对应的App.framework

# Debug模式的接入
通过Flutter提供的podspec接入对应的flutter模块


# 理想的iOS Flutter接入流程
1. 使用flutter create创建module或者project
1. coding...
1. 使用flutter build ios --release创建ios的App.framework 
1. 将flutter_assets合并到App.framework中 (提供工具)
1. 将App.framework和info.plist改变为unique的名称 (提供工具)
1. 上传<uniqueId>.framework到Host App的Flutter库repo (提供工具)
1. Host App通过podspec引用Flutter.framework和<uniqueId>.framework集合 (OK)

# 还需要做的事情
1. 自定义plugin在debug模式下集成方式
1. 自定义plugin在release模式下集成方式
1. FlutterKit iOS Pod