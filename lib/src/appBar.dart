import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  
  MyAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text(title),
      backgroundColor: Colors.transparent,
        border: Border.all(
          color: Colors.transparent,
          width: 0.0,
          style: BorderStyle.none),
    );
  }
}
