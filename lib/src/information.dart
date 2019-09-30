import 'package:flutter/material.dart';
import 'package:flutter_demo/service/information_service.dart';

class TabInformation extends StatelessWidget {
  void success(CheckVersionData res){
    print('----------success-----------');
    print(res.version);
  }
  void fail(){
    print('fail');
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey containerKey = GlobalKey();
    final size = MediaQuery.of(context).size;

    return Column(
      key: containerKey,
      children: <Widget>[
        Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0x22000000), style: BorderStyle.solid)
            )
          ),
          child: Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/img/xingba.jpg'),
              radius: 50,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              FlatButton(
                child: Text('+'),
                onPressed: (){
                  print(size.height);
                  print(size.width);
                  print(containerKey.currentContext.size.height);
                  print(containerKey.currentContext.size.width);
                  checkVersion(success, fail);
                },
              ),
            ],
          ),
        )
      ]
    );
  }
}