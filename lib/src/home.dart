import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/service/home_servicr.dart';

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
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: Text('GoFirstPage',
                style: TextStyle(
                  color: Colors.white,
                )),
              onPressed: ()=>Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (_)=> FirstPage())),
              pressedOpacity: 0.9,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: Text('GetHttp',
                style: TextStyle(
                  color: Colors.white,
                )),
              onPressed: (){
                getHttp();
              },
              pressedOpacity: 0.9,
            ),
          ),
        ],
      ),
    );
  }
}