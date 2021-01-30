import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/provider/Counter.dart';
import 'package:provider/provider.dart';

/// 主框架 Tabs的切换

class FindPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FindPagesState();
  }
}

class FindPagesState extends State<FindPages> {
  @override
  Widget build(BuildContext context) {
    print("刷新了");
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
