# Flutter使用Metal还是OpenGL
模拟器使用的是CALayer，真机是CAEAGLLayer，所以是不是可以认为Flutter底层有2套渲染机制，使用CA作为Fallback，所以姑且认为Flutter使用的是OpenGL

初步验证：
IOSSurfaceGL （OpenGL，通过Skia的GrGLGpu渲染） 和 IOSSurfaceSoftware （SKia）

# Plugin创建和管理

# UI Control Key & Reuse

# 动画

# 使用dart:ui自定义组件

# 使用Texture自定义组件
CVPixelBuffer 需要使用pow of 2 尺寸, 比如1024， 512 。。。

# Flutter如何更新视图
RenderBox

# Flutter是否可以使用平台相关的组件


# 使用Flutter构造相机App有哪些阻碍

# 构建画板App

# QA
* Flutter的例子跑真机只能跑release？

# FLutter user define macro adjust
FLUTTER_ROOT & FLUTTER_TARGET