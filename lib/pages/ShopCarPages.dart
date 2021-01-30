import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/provider/Counter.dart';
import 'package:provider/provider.dart';

/// 主框架 Tabs的切换

class ShopCarPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShopCarPagesState();
  }
}

class ShopCarPagesState extends State<ShopCarPages> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Counter>(context);
    return Scaffold(
      floatingActionButton: FlatButton(
          onPressed: () {
            pro.add();
          },
          child: Icon(Icons.add)),
      body: Text("${pro.count}"),
    );
  }
}
