import 'package:flutter/material.dart';

class BottomNavBarScreenContent extends StatefulWidget {
  BottomNavBarScreenContent({this.showIndex});
  final showIndex;
  @override
  BottomNavBarScreenContentState createState() => BottomNavBarScreenContentState();
}

class BottomNavBarScreenContentState extends State<BottomNavBarScreenContent> {
  @override
  Widget build(BuildContext context) {
    const colors = const [
      Colors.orange,
      Colors.deepOrangeAccent,
      Colors.blueAccent,
      Colors.cyanAccent,
    ];
    return Container(
      decoration: BoxDecoration(
        color: colors[widget.showIndex]
      ),
      alignment: Alignment.center,
      child: Text("Select : ${widget.showIndex}"),
    );
  }
}

class BottomNavBarScreen extends StatefulWidget {
  @override
  BottomNavBarScreenState createState() => BottomNavBarScreenState();
}

class BottomNavBarScreenState extends State<BottomNavBarScreen> {
  var currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    final Color inactiveTitleColor = Colors.black45;
    final Color activeTitleColor = Colors.orange;
    final bottomTabBarItems = [
      BottomNavigationBarItem(
        title: Text("我爱c++", style: TextStyle(color: currentIndex == 0 ? activeTitleColor : inactiveTitleColor)),
        icon: Icon(Icons.face, color: Colors.black45),
        activeIcon: Icon(Icons.face, color: Colors.orange),
      ),
      BottomNavigationBarItem(
        title: Text("我爱c", style: TextStyle(color:currentIndex == 1 ? activeTitleColor : inactiveTitleColor)),
        icon: Icon(Icons.face, color: Colors.black45),
        activeIcon: Icon(Icons.face, color: Colors.orange),
      ),
      BottomNavigationBarItem(
        title: Text("我爱dart", style: TextStyle(color: currentIndex == 2 ? activeTitleColor : inactiveTitleColor)),
        icon: Icon(Icons.face, color: Colors.black45),
        activeIcon: Icon(Icons.face, color: Colors.orange)
      ),
      BottomNavigationBarItem(
        title: Text("我爱Golang", style: TextStyle(color: currentIndex == 3 ? activeTitleColor : inactiveTitleColor)),
        icon: Icon(Icons.face, color: Colors.black45),
        activeIcon: Icon(Icons.face, color: Colors.orange),
      )
    ];
    return Scaffold(
        appBar: AppBar(
            title: Text("A Page Have Tab Bar")
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.amberAccent
          ),
          alignment: Alignment.center,
          child: BottomNavBarScreenContent(
              showIndex: currentIndex
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(items: bottomTabBarItems,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed)
    );
  }
}