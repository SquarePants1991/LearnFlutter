import 'package:flutter/material.dart';

class SimpleAnimationScreen extends StatefulWidget {
  @override
  SimpleAnimationScreenState createState() => SimpleAnimationScreenState();
}

class SimpleAnimationScreenState extends State<SimpleAnimationScreen> {

  var _width = 200.0;
  var _height = 100.0;
  var _bg = Colors.orange;
  var _showIndex = 0;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("简单动画"),
        ),
        body:
        Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              _buildAnimatedContainer(),
              _buildCrossFade()
            ],
          ),
        )
    );
  }

  Widget _buildAnimatedContainer() {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: _width,
          height: _height,
          decoration: BoxDecoration(
              color: _bg
          ),
        ),
        RaisedButton(
          child: Text("Animate"),
          onPressed: () {
            this.setState(() {
              _width = _width == 200.0 ? 300.0 : 200.0;
              _height = _height == 100.0 ? 200.0 : 100.0;
              _bg = _bg == Colors.green ? Colors.orange : Colors.green;
            });
          },
        )
      ],
    );
  }

  Widget _buildCrossFade() {
    // 有问题
    return
      Column(
        children: <Widget>[
          AnimatedCrossFade(firstChild: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.yellow
            ),
          ), secondChild: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                color: Colors.deepOrange
            ),
          ), crossFadeState: _showIndex == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond, duration: Duration(seconds: 3)),
          RaisedButton(
            child: Text("Animate"),
            onPressed: () {
              this.setState(() {
                _showIndex = _showIndex == 0 ? 1 : 0;
              });
            },
          )
        ],
      );
  }
}