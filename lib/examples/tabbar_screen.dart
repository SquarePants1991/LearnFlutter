import 'package:flutter/material.dart';

class TabBarScreen extends StatefulWidget {
  @override
  TabBarScreenState createState() => TabBarScreenState();
}

class TabBarScreenState extends State<TabBarScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _tabs = <Tab>[
    Tab(text: "asdsad"),
    Tab(text: "asdsad2")
  ];
  final _contents = <Widget>[
    Container(
      decoration: BoxDecoration(
        color: Colors.cyanAccent
      ),
    ),
    Container(
      decoration: BoxDecoration(
          color: Colors.deepOrange
      ),
    )
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text("A Page Have Tab Bar"),
          bottom: PreferredSize(child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:  TabBar(tabs: _tabs,
                controller: _tabController,
                labelColor: Colors.orange,
                indicatorColor: Colors.amber,
                unselectedLabelColor: Colors.black26),
          ), preferredSize: Size.fromHeight(44))
          
        ),
        body: TabBarView(children: _contents, controller: _tabController),
      drawer: Row(children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.orange
            ),
          )
        ),
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(0, 0, 0, 0)
              ),
            )
        )]
      ),
    );
  }
}