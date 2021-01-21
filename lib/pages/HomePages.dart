import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 主框架 Tabs的切换

class HomePages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePagesState();
  }
}

class HomePagesState extends State {


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("tio"),
      onPressed: (){
        Navigator.pushNamed(context, '/search');
      },
    );
  }
}
