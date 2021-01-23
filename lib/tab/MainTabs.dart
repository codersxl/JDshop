import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/pages/HomePages.dart';
import 'package:jdshop/pages/CategrPages.dart';
import 'package:jdshop/pages/ShopCarPages.dart';
import 'package:jdshop/pages/MePages.dart';
import 'package:jdshop/utils/ScreenUtils.dart';

/// 主框架 Tabs的切换

class MainTabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainTabsState();
  }
}

class MainTabsState extends State {
  var _pageController;

  //设置当前的index
  // ignore: non_constant_identifier_names
  int CurrntIndex = 0;
  List<Widget> listpages = [
    HomePages(),
    CategrPages(),
    ShopCarPages(),
    MePages()
  ];

  @override
  void initState() {
    // TODO: implement initState
    _pageController = new PageController(initialPage: CurrntIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(context);
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.center_focus_weak),
      //     onPressed: null,
      //   ),
      //   title: InkWell(
      //     onTap: (){
      //       Navigator.pushNamed(context, '/SearchPage');
      //       print("======================");
      //     },
      //     child: Container(
      //       height: ScreenUtils.height(72),
      //       padding: EdgeInsets.only(left: 10),
      //       decoration: BoxDecoration(
      //         color: Color.fromRGBO(233, 233, 233, 0.9),
      //         borderRadius: BorderRadius.circular(30),
      //
      //       ),
      //       child: Row(
      //         children: <Widget>[
      //           Icon(Icons.search),
      //           Text("笔记本")
      //         ],
      //       ),
      //     ),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.message),
      //       onPressed: null,
      //     ),
      //   ],
      // ),
      //BODY
      body: PageView(
        controller: _pageController,
        children: this.listpages,
        onPageChanged: (index) {
          setState(() {
            this.CurrntIndex = index;
          });
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.CurrntIndex,
        onTap: (index) {
          setState(() {
            this.CurrntIndex = index;
            print("aa${this.CurrntIndex}");
            _pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(title: Text("首页"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("分类"), icon: Icon(Icons.category)),
          BottomNavigationBarItem(
              title: Text("购物车"), icon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(title: Text("我的"), icon: Icon(Icons.person))
        ],
      ),
    );
  }
}
