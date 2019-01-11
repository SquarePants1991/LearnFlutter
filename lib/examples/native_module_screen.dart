import 'package:flutter/material.dart';
import 'package:learnflutter/utils/example_base_screen.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class NativeModuleScreen extends StatelessWidget {
  static const MethodChannel _pageChannel = const MethodChannel('me.ht/page');

  _jumpToNativePage() async {
    final isSuccess = await _pageChannel.invokeMethod("start");
  }

  @override
  Widget build(BuildContext context) {
    return ExampleBaseScreen(
      title: "本地模块",
      body: Center(
        child: RaisedButton(
          child: Text("跳转页面3334"),
          onPressed: _jumpToNativePage,
        ),
      ),
    );
  }
}
