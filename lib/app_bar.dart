import 'package:flutter/material.dart';

class HTAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.orange
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: null
          ),
          Expanded(
            child: Text("Funny Flutter"),
          ),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: null
          ),
        ],
      ),
    );
  }
}