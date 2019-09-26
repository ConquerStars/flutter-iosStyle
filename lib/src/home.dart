import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_demo/src/firstPage.dart';

class TabHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: ListView(
        children: <Widget>[
          Image.asset(
            "lib/assets/img/js.jpg",
          ),
          CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text('goFirstPage',
              style: TextStyle(
                color: Colors.white,
              )),
            onPressed: ()=>Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (_)=> FirstPage())),
            pressedOpacity: 0.9,
          ),
        ],
      ),
    );
  }
}