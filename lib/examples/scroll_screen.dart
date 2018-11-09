import 'package:flutter/material.dart';
import '../utils/example_base_screen.dart';

class ScrollScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExampleBaseScreen(
      title: "Scroll View",
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.orange
                  )),
              Container(
                  height: 1000,
                  decoration: BoxDecoration(
                      color: Colors.red
                  ))
            ],
          )
      ),
    );
  }
}