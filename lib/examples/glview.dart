import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';

class GLView extends StatefulWidget {
  @override
  GLViewState createState() => GLViewState();
}

class GLViewState extends State<GLView> {
  int textureId;

  static const glTextureService = const MethodChannel('me.ht/gltexture');

  Future<Null> _createTexture() async {
    final int textureID = await glTextureService.invokeMethod('create');
    textureId = textureID;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _createTexture();
  }

  @override
  dispose() {

  }

  @override
  Widget build(BuildContext context) {
    if (textureId == null) {
      return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.green
          )
      );
    }
    return Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.orange
            ),
          ),
          Container(
              width: 100,
              height:100,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child:Texture(textureId: textureId)
                )
              ),
              )
        ]
    );
  }
}