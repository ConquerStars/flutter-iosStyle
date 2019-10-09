import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/service/home_servicr.dart';

import 'package:flutter_demo/src/firstPage.dart';
import 'package:flutter_demo/utils/toast.dart';

class TabHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text('showDialog',
              style: TextStyle(
                color: Colors.white,
              )),
            onPressed: (){
              showCupertinoDialog(
                context: context,
                builder: (ctx) {
                  return CupertinoAlertDialog(
                    // title: Text('我是标题'),
                    content:Text('我是content？'),
                    actions:<Widget>[
                      CupertinoDialogAction(
                        child: Text('不是', style: TextStyle(color: Colors.grey)),
                        onPressed: (){
                          Toast.show('nope', context);
                          Navigator.maybePop(ctx);
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('是的'),
                        onPressed: (){
                          Toast.show('yeap', context);
                          Navigator.maybePop(ctx);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            pressedOpacity: 0.9,
          ),
        ),
        Image.asset(
          "lib/assets/img/js.jpg",
        ),
      ],
    );
  }
}