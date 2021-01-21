import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/pages/HomePages.dart';
import 'package:jdshop/pages/CategrPages.dart';
import 'package:jdshop/pages/FindPages.dart';
import 'package:jdshop/pages/ShopCarPages.dart';
import 'package:jdshop/pages/MePages.dart';

/// 主框架 Tabs的切换

class MainTabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainTabsState();
  }
}

class MainTabsState extends State {
  //设置当前的index
  // ignore: non_constant_identifier_names
  int CurrntIndex = 1;
  var list = [
    HomePages(),
    CategrPages(),
    FindPages(),
    ShopCarPages(),
    MePages()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("shop"),
      ),
      //BODY
      body: this.list[CurrntIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.CurrntIndex,
        onTap: (index) {
          setState(() {
            this.CurrntIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(title: Text("首页"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("分类"), icon: Icon(Icons.category)),
          BottomNavigationBarItem(
              title: Text("发现"), icon: Icon(Icons.find_in_page)),
          BottomNavigationBarItem(
              title: Text("购物车"), icon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(title: Text("我的"), icon: Icon(Icons.person))
        ],
      ),
    );
  }
}
