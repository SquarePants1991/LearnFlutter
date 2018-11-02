import 'package:learnflutter/utils/example_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimationBuilderScreen extends StatefulWidget {
  @override
  AnimationBuilderScreenState createState() => AnimationBuilderScreenState();
}

class AnimationBuilderScreenState extends State<AnimationBuilderScreen> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3))..repeat();
  }
  
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleBaseScreen(
      title: "AnimatedBuilder",
      body:
      Container(
        alignment: Alignment.center,
        child: AnimatedBuilder(
          animation: _animationController,
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.green
            ),
            child: Text("Loading..."),
          ),
          builder: (context, Widget child) {
            return Transform.rotate(angle: _animationController.value * 3.14 * 2.0, child: child);
          },
        )
      )
    );
  }
}