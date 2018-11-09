import 'package:flutter/material.dart';
import '../utils/example_base_screen.dart';

class ComplexScrollScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExampleBaseScreen(
        title: "复杂ScrollView",
        body: _buildCustomScrollView(context)
    );
  }

  Widget _buildCustomScrollView(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              title: Text("Funny Images")
          ),
        ),
        SliverGrid(
            delegate: SliverChildBuilderDelegate((BuildContext childBuildContext, int index) {
              return Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(13),
                  child: Text("${index}"),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[100 * (index % 9)]
                  ));
            }, childCount: 20),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.0
            ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext childBuildContext, int index) {
            return Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(13),
              child: Text("${index}"),
              decoration: BoxDecoration(
                  color: Colors.lightBlue[100 * (index % 9)]
              ),
              height: index % 3 * 100.0
            );
          }),
        )
      ],
    );
  }
}