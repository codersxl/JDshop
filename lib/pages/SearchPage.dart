import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/utils/ScreenUtils.dart';

class SearchPage extends StatelessWidget {
  Widget _getWraps(String value) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(233, 233, 233, 0.9),
          borderRadius: BorderRadius.circular(30)),
      child: Text(value),
    );
  }

  Widget _getTiTle(context, value) {
    return Container(
      child: Text("${value}", style: Theme.of(context).textTheme.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderSide: BorderSide.none, //去除底线
              borderRadius: BorderRadius.circular(30),
            )),
          ),
          height: ScreenUtils.height(72),
          padding: EdgeInsets.only(left: 10, bottom: ScreenUtils.height(5)),
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.9),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: null,
          // ),
          InkWell(
            onTap: () {
              print("=======搜索=======");
            },
            child: Container(
              height: ScreenUtils.height(80),
              width: ScreenUtils.width(80),
              child: Row(
                children: <Widget>[Text("搜索")],
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            _getTiTle(context, "热搜"),
            Divider(),
            Wrap(
              children: <Widget>[
                _getWraps("女装"),
                _getWraps("女装"),
                _getWraps("女装"),
                _getWraps("女装"),
                _getWraps("女装"),
                _getWraps("女装"),
                _getWraps("女装"),
              ],
            ),
            _getTiTle(context, "历史"),
            Divider(),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("历史"),
                ),
                Divider(),
                ListTile(
                  title: Text("历史"),
                ),
                Divider(),
                ListTile(
                  title: Text("历史"),
                ),
                Divider(),

              ],
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: ScreenUtils.width(500),
              height: ScreenUtils.height(64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(Icons.delete), Text("清空历史记录")],
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(233, 233, 233, 0.9), width: 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
