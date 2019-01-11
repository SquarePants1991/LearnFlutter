import 'package:flutter/material.dart';
import '../utils/example_base_screen.dart';
import 'package:flutter/animation.dart';
import 'dart:math';

class LayoutPracticeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LayoutPracticeScreenState();
}

class LayoutPracticeScreenState extends State<LayoutPracticeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ExampleBaseScreen(
      title: "布局练习",
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          AnimatedBuilder(
            animation: _animationController,
            child: FlatButton(
              child: Text('点我 ${_isExpanded ? "关闭我---" : "展开我"}'),
              onPressed: () {
                if (_isExpanded) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
            builder: (context, child) {
              final num width = _animationController.value * 100 + 100;
              return Container(
                  width: width,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.green),
                  child: child);
            },
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.red),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
