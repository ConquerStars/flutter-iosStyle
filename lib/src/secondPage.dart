import 'package:flutter/material.dart';

import 'package:flutter_demo/src/appBar.dart';

class SecondPage extends StatefulWidget {
  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          MyAppBar('SecondPage'),
          Text("这是第二个界面")
        ],
      ),
    );
  }
}