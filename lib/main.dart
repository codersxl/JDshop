import 'package:flutter/material.dart';
import 'package:jdshop/routes/router.dart';
import 'tab/MainTabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'shop',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: MyHomePage(),
      onGenerateRoute: onGenerateRoute,
      initialRoute: '/ProductList',
    );
  }
}

/// 对Tbs进行抽取

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MainTabs();
  }
}
