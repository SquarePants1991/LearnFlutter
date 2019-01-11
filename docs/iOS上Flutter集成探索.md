# 官方的集成方案
[https://github.com/flutter/flutter/ruby/Add-Flutter-to-existing-apps](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps)
Flutter官方提供的方案主要通过CocoaPods集成单个项目，集成主要通过2个途径。
1. Build Phase中的Run Script进行flutter项目的编译打包
1. 通过ruby脚本将打包的产物通过CocoaPods集成到宿主项目

# 官方方案的问题
### 宿主项目和flutter项目耦合过高
1. 要在宿主项目的Podfile指定flutter项目的路径
1. 要在宿主项目的Build Phase中增加脚本

# 如何解决
分析flutter打包和加载流程，寻找可以优化的操作路径

# flutter打包产物探索
flutter打包出来的代码分为2种模式，JIT和AOT

## JIT
JIT模式下，可执行性产物并不是二进制机器码，而是运行在DartVM上的中间代码，要打出JIT模式的包，可以使用`flutter build ios --debug`命令，打包后，你会得到如下产物。
```
AssetManifest.json
assets
FontManifest.json
fonts
isolate_snapshot_data
vm_snapshot_data
kernel_blob.bin
...
```
> 如果你是创建的flutter project，你可以在`ios/Flutter/flutter_assets`下找到这些文件，如果是flutter module，可以在`.ios/Flutter/flutter_assets`下找到这些文件
这些产物中，大多数都是资源相关的，比如`AssetManifest.json`，`FontManifest.json`等等，`isolate_snapshot_data`和`vm_snapshot_data`是flutter的isolate和vm数据区的快照，`kernel_blob.bin`包含了将在DartVM上运行的代码。当我们拥有这些资源，我们就可以在JIT模式下运行我们的flutter项目了。

## AOT
AOT模式下，flutter项目被编译为了二进制机器码，在iOS下，呈现为Dynamic Framework的形势，使用`flutter build ios --release`进行打包，可以得到AOT模式下的产物，主要包括2个部分
1. flutter_assets目录，这个目录下除了没有`kernel_blob.bin` ，`isolate_snapshot_data` ，`vm_snapshot_data`，其他和JIT模式下一模一样
1. App.framework,这个是flutter项目代码编译链接出来的动态库，你也可以理解为`kernel_blob.bin`中的代码转移到了`App.framework`

> 如果你是创建的flutter project，你可以在`ios/Flutter/`下找到这些文件，如果是flutter module，可以在`.ios/Flutter/`下找到这些文件

这两种模式都依赖了一个基础库`Flutter.framework`，也就是说在JIT模式下想要运行项目，需要`flutter_assets`下的所有资源以及Flutter.framework。在AOT模式下，则需要`flutter_assets`，`Flutter.framework`，`App.framework`。

# AOT模式下的解耦探索
## Flutter.framework的解耦
首先我们可以为`Flutter.framework`建立单独的CocoaPods Library，让宿主项目通过pod引用到`Flutter.framework`，同时我们也可以在这个CocoaPods Library中对`Flutter.framework`的接口进行2次封装，比如插件的注册，路由系统等等。下面是一个简单的CocoaPods Library的例子。
```
Pod::Spec.new do |s|
  s.name = 'FlutterKit'

  ...

  s.vendored_frameworks = 'FlutterKit/Frameworks/Flutter.framework'
  s.weak_frameworks = ['Flutter']
end
```
这个podspec主要引用了`Flutter.framework`，并且把它标记为weak framework，因为`Flutter.framework`并不会在App打开时被load，如果不被标记为weak，那么App在启动时会因为找不到这个动态库而报错。这一点对于App.framework同样适用。回到宿主App这边，它只需要在Podfile中增加`pod 'FlutterKit'`即可。

## App.framework的解耦
对于`App.framework`，我们需要做一些整合和修改，通过flutter/engine的源码可以了解到`App.framework`的加载流程。

### App.framework如何被选中
在官方集成方案的项目模板中， 直接通过`FlutterViewController* flutterViewController = [[FlutterViewController alloc] init];`初始化Flutter项目的容器VC，那么问题来了，这个毫无参数的默认初始化时如何寻找到App.framework的呢？在源码`FlutterDartProject.mm`文件中可以找到答案，在`static blink::Settings DefaultSettingsForProcess(NSBundle* bundle = nil)`函数里我们可以发现`settings.application_library_path`的设置逻辑，也就是Flutter项目AOT包中可执行行文件的路径。逻辑分为下面几步。
1. 通过`blink::DartVM::IsRunningPrecompiledCode()`判断是否是在执行AOT代码
1. 是否指定了明确的NSBundle，如果指定了，使用该bundle的可执行文件路径，否则继续往下，这一步很重要，后面会用到它
1. Main Bundle是否配置了`FLTLibraryPath`，配置了则使用它，否则继续往下
1. Main Bundle的`Frameworks/App.framework`路径是否存在，存在则是使用它，否则就永远找不到了

第四步就是我们通过`[[FlutterViewController alloc] init]`初始化会触发的逻辑，如果我们想要让`App.framework`的加载不那么耦合，我们需要进入第二步的逻辑，在此之前，我们再深入了解一下`flutter_assets`这个目录的定位方式。代码往下看，任然在`DefaultSettingsForProcess`函数中，有对于`settings.assets_path`赋值的逻辑，`settings.assets_path`需要保存的是flutter_assets目录存在的路径，代码逻辑如下

1. 通过传入的NSBundle获取flutter项目打包的资源目录名称，它会先去寻找NSBundle中`FLTAssetsPath`的配置项，如果没有则使用`flutter_assets`作为名称
1. 使用上面的名称在传入的NSBundle中获取到资源目录的绝对路径，为空则继续往下
1. 使用Main Bundle获取到资源目录的绝对路径，为空则打印错误

### 对App.framework和资源的整合
我们可以把App.framework当做一个NSBundle，将flutter_assets目录加入到其中，最终目录结构如下。使用它最直接的方式就是把它拖到宿主项目，让后将Status设置为Optional。
* App.framework
  * App
  * Info.plist
  * flutter_assets
    * packages
    * LICENSE
    * fonts
    * FontManifest.json
    * assets
    * AssetManifest.json

### 整合后App.framework的加载
为了加载整合后的App.framework，我们除了`FlutterViewController`，还需要使用到`FlutterDartProject`，也就是上面被分析过的类。通过寻找App.framework的路径，然后使用该路径初始化一个NSBundle对象，最后使用它初始化`FlutterDartProject`对象。
```
NSString *customBundlePath = [[NSBundle mainBundle] pathForResource:@"App" ofType:@"framework" inDirectory:@"./Frameworks"];
NSBundle *customBundle = [NSBundle bundleWithPath:customBundlePath];
FlutterDartProject *project = [FlutterDartProject.alloc initWithPrecompiledDartBundle:customBundle];
```
这里我使用的是`initWithPrecompiledDartBundle`方法，代表着这是一个AOT模式下的包。接着使用project初始化`FlutterViewController`
```
FlutterViewController *flutterVC = [[FlutterViewController alloc] initWithProject:project nibName:nil bundle:customBundle];
```
到此，我们便手动加载出了flutter项目，我们还可以做一下发散，是否可以将不同flutter项目打包成App.framework，然后每个FlutterViewController加载一个项目呢?

### 单宿主多Flutter项目的支持
由于每个Flutter项目打包出来都叫App.framework，我们并不能直接将多个Flutter项目的产物直接塞进一个宿主项目，这样会有冲突，