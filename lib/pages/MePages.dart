import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/utils/ScreenUtils.dart';
/// 主框架 Tabs的切换

class MePages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  MePagesState();
  }
}

class MePagesState extends State {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

       body: ListView(
         children: <Widget>[
           Container(
             height: ScreenUtils.height(220),
             width: double.infinity,
             decoration: BoxDecoration(
                 image: DecorationImage(
                     image: AssetImage('images/user_bg.jpg'), fit: BoxFit.cover)),
             child: Row(
               children: <Widget>[
                 Container(
                   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                   child: ClipOval(
                     child: Image.asset(
                       'images/user.png',
                       fit: BoxFit.cover,
                       width: ScreenUtils.width(100),
                       height: ScreenUtils.width(100),
                     ),
                   ),
                 ),
                 // Expanded(
                 //   flex: 1,
                 //   child: Text("登录/注册",style: TextStyle(
                 //     color: Colors.white
                 //   )),
                 // )

                 Expanded(
                   flex: 1,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text("用户名：124124125",
                           style: TextStyle(
                               color: Colors.white,
                               fontSize: ScreenUtils.size(32))),
                       Text("普通会员",
                           style: TextStyle(
                               color: Colors.white,
                               fontSize: ScreenUtils.size(24))),
                     ],
                   ),
                 )
               ],
             ),
           ),
           ListTile(
             leading: Icon(Icons.assignment, color: Colors.red),
             title: Text("全部订单"),
           ),
           Divider(),
           ListTile(
             leading: Icon(Icons.payment, color: Colors.green),
             title: Text("待付款"),
           ),
           Divider(),
           ListTile(
             leading: Icon(Icons.local_car_wash, color: Colors.orange),
             title: Text("待收货"),
           ),
           Container(
               width: double.infinity,
               height: 10,
               color: Color.fromRGBO(242, 242, 242, 0.9)),
           ListTile(
             leading: Icon(Icons.favorite, color: Colors.lightGreen),
             title: Text("我的收藏"),
           ),
           Divider(),
           ListTile(
             leading: Icon(Icons.people, color: Colors.black54),
             title: Text("在线客服"),
           ),
           Divider(),
         ],
       ));

  }
}
