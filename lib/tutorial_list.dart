import 'package:flutter/material.dart';
import 'dart:core';

typedef Widget ScreenCreateCallBack();
class TutorialEntry {
  TutorialEntry({this.title, this.description, this.screen});
  final String title;
  final String description;
  final ScreenCreateCallBack screen;
}

typedef void TutorialRowTapCallback(int row, TutorialEntry entry);
class TutorialList extends StatelessWidget {
  TutorialList({this.onRowTapped, this.entries});

  final TutorialRowTapCallback onRowTapped;
  final List<TutorialEntry> entries;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, i) {
          var entry = entries[i];
          return _buildRow(i, entry);
        },
        itemCount: entries.length);
  }

  Widget _buildRow(int index, TutorialEntry entry) {
    return GestureDetector(
        onTap: () {
          onRowTapped(index, entry);
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            margin: const EdgeInsetsDirectional.only(bottom: 1),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(entry.title,
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                inherit: false,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 15))
                    ),
                    IconButton(
                      icon: Icon(Icons.navigate_next)
                    )
                  ],
                ),
                Divider(color: Colors.black12, height: 1,)
              ],
            ))
    );
  }
}