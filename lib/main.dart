import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
// import 'package:toast/toast.dart';
import 'package:flutter_demo/utils/toast.dart';

import 'package:flutter_demo/src/home.dart';
import 'package:flutter_demo/src/found.dart';
import 'package:flutter_demo/src/information.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  String title = 'Flutter_demo';
  DateTime lastPopTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(this.title),
          backgroundColor: Colors.transparent,
          border: Border.all(
            color: Colors.transparent,
            width: 0.0,
            style: BorderStyle.none),
        ),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: CupertinoColors.activeBlue,
            backgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                title: Text('主页'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.eye),
                title: Text('发现')
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.folder),
                title: Text('我的')
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index){
            return CupertinoTabView(
              builder: (BuildContext context){
                if(index == 0){
                  return TabHome();
                } else if(index == 1){
                  return TabFound();
                } else{
                  return TabInformation();
                }
              }
            );
          },
        ),
      ),
      onWillPop: quit,
    );
  }
  Future<bool> quit() async {
    if(lastPopTime == null || DateTime.now().difference(lastPopTime)>Duration(seconds:2)){
      lastPopTime = DateTime.now();
      Toast.show('再按一次退出', context);
    } else {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    return false;
  }
}