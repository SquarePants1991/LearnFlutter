import 'package:flutter/material.dart';
import 'package:learnflutter/utils/example_base_screen.dart';
import 'paint_screen.dart';

class HeroAnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExampleBaseScreen(
      title: "Hero动画",
      body: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ExampleBaseScreen(
              title: "EscapeCat",
              body: Hero(tag: "escapecat", child: Container(
                width: 300,
                height:300,
                decoration: BoxDecoration(
                  color: Colors.deepOrange
                ),
              ))
            );
          }));
        },
        child: Hero(tag: "escapecat", child: FlutterLogo()),
      )
    );
  }
}