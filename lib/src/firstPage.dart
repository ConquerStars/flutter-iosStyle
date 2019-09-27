import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_demo/src/appBar.dart';
import 'package:flutter_demo/src/secondPage.dart';

class FirstPage extends StatefulWidget {
  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: Column(
        children: <Widget>[
          MyAppBar('FirstPage'),
          Text("这是第一个界面"),
          CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text('goSecondPage',
              style: TextStyle(
                color: Colors.white,
              )),
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=> SecondPage())),
            pressedOpacity: 0.9,
          )
        ],
      ),
    );
  }
}