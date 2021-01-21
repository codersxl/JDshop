import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("ser"),
        ),
        body: Text("启动页面"),
      ),
    );
  }
}
