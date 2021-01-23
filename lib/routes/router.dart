

import 'package:flutter/material.dart';
import 'package:jdshop/pages/SearchPage.dart';
import 'package:jdshop/pages/SplashPages.dart';
import 'package:jdshop/tab/MainTabs.dart';
import 'package:jdshop/ui/ProductList.dart';


//配置路由
final routes = {
  '/': (context) =>MainTabs(),
  '/SearchPage': (context) => SearchPage(),
  '/SplashPages':(context)=>SplashPages(),
  '/ProductList':(context,{arguments})=>ProductList(arguments:arguments),
};

//固定写法
// ignore: missing_return, top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
