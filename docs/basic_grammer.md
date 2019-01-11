# 纯虚类
dart:
abstruct class ClassName {} 显式的interface

c++:
virtual void func() = 0;

# Interface 
每一个类都是隐式的interface，可以被implements，或者显式的实现抽像类

QA：
* 实现的方法是否可选

# Override
覆盖方法时如果参数类型存在downcast，使用covariant表示这个是安全的行为

对于dynamic类型，可以Override noSuchMethod来处理不支持的方法调用

Q:
* 多继承下的noSuchMethod判断方式深入

# Operator Override
支持部分符号重载，不支持自定义符号

Q:
* 对于基本类型或内置类型如何进行类C++的friend符号重载

# Mixin
可以使用Mixin拆分类


# Const 
* static 方法可以作为const常量

# 泛型
* 泛型类的类型会在runtime中携带，oc和java中则不会
* 可以使用类型约束从句，比如extends， （implements支不支持呢？）
* 支持泛型方法

# 库
* 懒加载，使用 deferred as， await xxx.loadLibrary();
* loadLibrary可以被多次调用

# async & stream
* 是否可以将重型计算放入async方法
* stream类似于ReactiveCocoa里的信号流，使用await for

# 生成方法
* Iterable sync
* Stream async
* yield*如何优化？

# Callable Class
* call & apply

# isolate
* 并行编程
* 使用Port通讯

# typedef
* 使用typedef做类型的alias，typedef xxx = oldType

# 注解
* 注解都是const值
* 使用反射获取注解


