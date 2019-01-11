import 'package:flutter/material.dart';
import '../utils/example_base_screen.dart';

class ImageItemData {
  String url;
  String title;
  ImageItemData({this.url, this.title}) {
    url = "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2597246983,1958389207&fm=26&gp=0.jpg";
    title = "This is a title";
  }
}

class TabListScreen extends StatefulWidget {
  @override
  TabListScreenState createState() => TabListScreenState();
}

class TabListScreenState extends State<TabListScreen> with SingleTickerProviderStateMixin {
  Map<String, List<ImageItemData>> tabList;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    tabList = Map();
    tabList["Funny Story"] = [
      ImageItemData(),
      ImageItemData()
    ];
    tabList["Funny Pics"] = [
      ImageItemData(),
      ImageItemData()
    ];
    _tabController = TabController(length: tabList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ExampleBaseScreen(
        title: "Multi Tab List",
        body: Column(
          children: <Widget>[
            TabBar(tabs: _buildTabs(), controller: _tabController),
            Expanded(
              child: TabBarView(children: _buildLists(), controller: _tabController),
            )
          ],
        )
    );
  }

  List<Tab> _buildTabs() {
    List<Tab> _tabs = List();
    for(final key in tabList.keys) {
      _tabs.add(Tab(text: key));
    }
    return _tabs;
  }

  List<Widget> _buildLists() {
    List<Widget> widgets = List();
    for(final key in tabList.keys) {
      widgets.add(_buildList(tabList[key]));
    }
    return widgets;
  }

  Widget _buildList(List<ImageItemData> imageDatas) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green
      ),
      child: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext buildContext, int index) {
            final imageData = imageDatas[index % 2];
            return Container(
              decoration: BoxDecoration(
                  color: Colors.lightBlue[index % 9 * 100]
              ),
              child: Column(
                children: <Widget>[
                  PreferredSize(child:
                  Padding(padding: const EdgeInsets.all(13), child:
                  Image.network(imageData.url)), preferredSize: Size.fromHeight(100)),
                  Padding(
                    child: Text(imageData.title,style: TextStyle(fontSize: 20)),
                    padding: const EdgeInsets.all(5),
                  )
                ],
              ),
              alignment: Alignment.center,
            );
          }),
    );
  }
}