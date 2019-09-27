import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_demo/src/appBar.dart';

class SecondPage extends StatefulWidget {
  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<SecondPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _name;
  String _psw;
  
  void _onSubmit() {
    final form = _formKey.currentState;
    print(form);
    if(form.validate()) {
      form.save();
      print(this._name);
      print(this._psw);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: Column(
        children: <Widget>[
          MyAppBar('SecondPage'),
          Material(
            color: CupertinoColors.white,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding( // 账号input
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Container(
                      height: 80,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: '账号/手机号',
                          border: OutlineInputBorder(),
                        ),
                        validator: (val)=> (val == null || val.isEmpty)?'请输入账号/手机号':null,
                        onSaved: (val) {
                          _name = val;
                        },
                      ),
                    ),
                  ),
                  Padding( // 密码input
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child:  Container(
                      height: 80,
                      child: TextFormField(
                      decoration: InputDecoration(
                          labelText: '密码',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (val)=> (val == null || val.isEmpty)?'请输入密码':null,
                        onSaved: (val) {
                          _psw = val;
                        },
                      ),
                    ),
                  ),
                  CupertinoButton( // 提交按钮
                    color: CupertinoColors.activeBlue,
                    child: Text('Submit',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                    onPressed: _onSubmit,
                    pressedOpacity: 0.9,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}