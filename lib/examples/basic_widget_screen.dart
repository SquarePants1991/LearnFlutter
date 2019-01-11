import 'package:flutter/material.dart';

class BasicWidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basic Widgets")),
      body: Column(children: <Widget>[
        _buildCloseButton(context),
        _buildContainerExample(),
        _buildRowExample(),
        _buildImagesExample()
      ]),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return RaisedButton(
      child: Text("Go Back!"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildContainerExample() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.amber, width: 10)),
        height: 100,
        transform: Matrix4.rotationZ(0.01),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.lightGreen),
          child: Text("Thi is a container"),
        ));
  }

  Widget _buildRowExample() {
    const decoration = BoxDecoration(
        color: Colors.amberAccent,
        border: Border(
            bottom: BorderSide(color: Colors.orange, width: 7),
            top: BorderSide(color: Colors.pink, width: 10)));
    return Container(
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      border: Border(
                          bottom: BorderSide(color: Colors.orange, width: 7),
                          top: BorderSide(color: Colors.pink, width: 10))),
                  alignment: Alignment.center,
                  child: Text("Left Text", style: TextStyle(fontSize: 11))),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                decoration: decoration,
                child: Text("Center Text"),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: decoration,
                child: Text("Right Text"),
              ),
            )
          ],
        ));
  }

  Widget _buildImagesExample() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Image.asset("assets/icons/gem_icon.png")),
            Expanded(
                child: Image.network(
                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540666982243&di=c426e2c8ea54247f73a08cb6f9bb577a&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01f77a592e71a7b5b3086ed47397ad.png"))
          ],
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 13),
            alignment: Alignment.center,
            padding:
                const EdgeInsets.only(left: 13, right: 13, top: 8, bottom: 15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/bubble_dialog.png"),
                    fit: BoxFit.fill,
                    centerSlice: Rect.fromLTWH(10, 10, 20, 10),
                    colorFilter:
                        ColorFilter.mode(Colors.deepOrange, BlendMode.srcIn))),
            child: Text(
                "To automatically perform pixel-density-aware asset resolution, specify the image using an AssetImage and make sure that a MaterialApp, WidgetsApp, or MediaQuery widget exists above the Image widget in the widget tree.",
                style: TextStyle(color: Colors.white, fontSize: 14)))
      ],
    );
  }
}
