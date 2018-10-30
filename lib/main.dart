import 'package:flutter/material.dart';
import 'dart:core';
import 'tutorial_list.dart';
import 'app_bar.dart';
import 'examples/basic_widget_screen.dart';
import 'examples/bottom_navbar_screen.dart';
import 'examples/tabbar_screen.dart';
import 'examples/paint_screen.dart';

void main() {
  return runApp(MaterialApp(
    title: 'Learn Flutter',
    home: LearnFlutter(),
    theme: ThemeData(
      primaryColor: Colors.green
    ),
  ));
}

class LearnFlutter extends StatelessWidget {

  final entries = [
  TutorialEntry(title: "基础Widget", screen: () => BasicWidgetScreen()),
  TutorialEntry(title: "BottomNavBar结构", screen: () => BottomNavBarScreen()),
  TutorialEntry(title: "TabBar结构", screen: () => TabBarScreen()),
  TutorialEntry(title: "自定义绘制", screen: () => PaintScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildHomePage(context);
  }

  Widget _buildAppbar(String title) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.verified_user),
      ),
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
        ),
        IconButton(
          icon: Icon(Icons.info),
        )
      ],
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar("Learn Flutter"),
        body: Container(
            decoration: BoxDecoration(
                color: Colors.white
            ),
            padding: const EdgeInsets.all(0.0),
            child: TutorialList(
                onRowTapped: (index, entry) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => entry.screen() ));
                },
                entries: entries
            )
        )
    );
  }
}
