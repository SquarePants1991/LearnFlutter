import '../utils/example_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class TransitionScreen extends StatefulWidget {
  @override
  TransitionScreenState createState() => TransitionScreenState();
}

class TransitionScreenState extends State<TransitionScreen> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decoratedTransition = DecorationTween(
        begin: BoxDecoration(color: Colors.red),
        end: BoxDecoration(color: Colors.orange)
    );
    return ExampleBaseScreen(
      title: "Transition 效果",
      body: Column(
          children: <Widget>[
            DecoratedBoxTransition(
                decoration: decoratedTransition.animate(_animationController),
                child: FadeTransition(
                  opacity: _animationController,
                  child: Container(
                    width: 100,
                    height: 100,
                  ),
                )
            ),
            FadeTransition(
              opacity: _animationController,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.cyan
                ),
                width: 100,
                height: 100,
              ),
            ),
            Stack(
                children: <Widget>[
                  PositionedTransition(
                    rect: RelativeRectTween(
                      begin: RelativeRect.fromSize(Rect.fromLTWH(0, 0, 100, 100), Size(100, 100)),
                      end: RelativeRect.fromSize(Rect.fromLTWH(0, 0, 100, 100), Size(4, 4)),
                    ).animate(_animationController),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow
                      ),
                      width: 100,
                      height: 100,
                    ),
                  )
                ])
          ]),
    );
  }
}