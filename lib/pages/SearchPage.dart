import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/utils/ScreenUtils.dart';
import 'package:jdshop/utils/SharedPrefrcneUtils.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  var _keyWords;
  var _historyListData = [];

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

  _getData() async {
    var data = await SharedPrefrcneUtils.getHistoryList();
    setState(() {
      this._historyListData = data;
    });
  }

  Widget _historyListWidget() {
    if (_historyListData.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text("历史记录", style: Theme.of(context).textTheme.title),
          ),
          Divider(),
          Column(
            children: this._historyListData.map((value) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text("${value}"),
                    onLongPress: () {
                      this._showAlertDialog("${value}");
                    },
                  ),
                  Divider()
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  SharedPrefrcneUtils.clearHistoryList();
                  this._getData();
                },
                child: Container(
                  width: ScreenUtils.width(400),
                  height: ScreenUtils.height(64),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.delete), Text("清空历史记录")],
                  ),
                ),
              )
            ],
          )
        ],
      );
    } else {
      return Text("");
    }
  }

  _showAlertDialog(keywords) async {
    var result = await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息!"),
            content: Text("您确定要删除吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  print("取消");
                  Navigator.pop(context, 'Cancle');
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  //注意异步
                  await SharedPrefrcneUtils.removeHistoryData(keywords);
                  this._getData();
                  Navigator.pop(context, "Ok");
                },
              )
            ],
          );
        });

    //  print(result);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            onChanged: (value) {
              this._keyWords = value;
            },
            autofocus: true,
            decoration: InputDecoration(
                icon: Icon(Icons.search),
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
              setState(() {
                SharedPrefrcneUtils.setHistoryData(this._keyWords);
                // Navigator.pushReplacementNamed(context, '/productList',
                //     arguments: {"keywords": this._keywords});
              });
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
            _historyListWidget()
          ],
        ),
      ),
    );
  }
}
