import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/config/Config.dart';
import 'package:jdshop/model/CateModel.dart';
import 'package:jdshop/utils/ScreenUtils.dart';

/// 主框架 Tabs的切换

class CategrPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategrPagesState();
  }
}

class CategrPagesState extends State with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLeftData();
  }

  var _leftData = [];
  var _rightData = [];

  //左侧组建的

  Widget leftWidget(leftwidth) {
    if (this._leftData.length > 0) {
      return //左侧的页面
          Container(
              width: leftwidth,
              height: double.infinity,
              child: ListView.builder(
                  itemCount: this._leftData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              //防止重复点击
                              if (this.selectedItem != index) {
                                this.selectedItem = index;
                                this._getrightData(this._leftData[index].sId);
                              }
                            });
                          },
                          child: Container(
                            color: this.selectedItem == index
                                ? Colors.red
                                : Colors.white,
                            child: Text(
                              "${this._leftData[index].title}",
                              textAlign: TextAlign.center,
                            ),
                            width: double.infinity,
                            height: ScreenUtils.height(84),
                            padding:
                                EdgeInsets.only(top: ScreenUtils.height(24)),
                          ),
                        ),
                        Divider(
                          height: ScreenUtils.height(1),
                        )
                      ],
                    );
                  }));
    } else {
      return Container(
        width: leftwidth,
        height: double.infinity,
        child: Text("正在加载中。。。。"),
      );
    }
  }

  //右侧组件的编写
  Widget rightWidget(rithwidth, rightHeight) {
    if (this._rightData.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          color: Color.fromRGBO(240, 246, 246, 0.9),
          height: double.infinity,
          child: GridView.builder(
              itemCount: this._rightData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: rithwidth / rightHeight,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                String pic = this._rightData[index].pic;
                pic = Config.domain + pic.replaceAll("\\", "/");
                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/ProductList',arguments: {
                      "cid":this._rightData[index].sId
                    });
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            pic,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          height: ScreenUtils.height(28),
                          child: Text("${this._rightData[index].title}"),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.all(10),
            color: Color.fromRGBO(240, 246, 246, 0.9),
            height: double.infinity,
         child: Text("正在加载中。。。。。"),
        ),
      );
    }
  }

  //左侧数据的请求
  _getLeftData() async {
    String url = "${Config.domain}api/pcate";
    var re = await Dio().get(url);
    var cate = CateModel.fromJson(re.data);
    setState(() {
      this._leftData = cate.result;
      print("aaa${this._leftData[0].toString()}");
      if (this._leftData.length > 0) {
        _getrightData(this._leftData[0].sId);
        print("aaa${this._leftData[0].sId}");
      }
    });
  }

  //左侧数据的请求
  _getrightData(pid) async {
    String url = "${Config.domain}api/pcate?pid=${pid}";
    var re = await Dio().get(url);
    var cate = CateModel.fromJson(re.data);
    setState(() {
      this._rightData = cate.result;
      print("aaas${this._rightData[0].toString()}");
    });
  }

  int selectedItem = 0;
  int nextSelected = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(context);
    var leftwidth = ScreenUtils.getScreenWidth() / 4;
    var rithwidth = (ScreenUtils.getScreenWidth() - leftwidth - 20 - 20) / 3;
    rithwidth = ScreenUtils.width(rithwidth);
    var rightHeight = rithwidth + ScreenUtils.height(28);

    return Row(
      children: <Widget>[
        //左侧组件
        leftWidget(leftwidth),
        //右侧
        rightWidget(rithwidth, rightHeight)
      ],
    );
  }

  @override
  // 保持页面数据Ubuntu重新请求
  bool get wantKeepAlive => true;
}
