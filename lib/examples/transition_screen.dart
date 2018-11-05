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
            Container(
              height: 200,
              width: 200,
              child: Stack(
                  children: <Widget>[
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromRect(
                          Rect.fromLTWH(10, 10, 100, 100),
                          Rect.fromLTRB(0.0, 0.0, 200.0, 200.0),
                        ),
                        end: RelativeRect.fromRect(
                          Rect.fromLTWH(50, 50, 140, 140),
                          Rect.fromLTRB(0.0, 00.0, 200.0, 200.0),
                        )
                      ).animate(_animationController),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow
                        )
                      ),
                    )
                  ])
            ),
            RotationTransition(
              turns: _animationController,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.cyan
                ),
                width: 40,
                height: 40,
              ),
            ),
            ScaleTransition(
              scale: _animationController,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.cyan
                ),
                width: 40,
                height: 40,
              ),
            ),
          ]),
    );
  }
}