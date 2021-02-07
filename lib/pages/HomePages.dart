import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jdshop/config/Config.dart';
import 'package:jdshop/model/FocusModel.dart';
import 'package:jdshop/model/ProducModel.dart';
import 'package:jdshop/model/ProducHotModel.dart';
import 'package:jdshop/utils/LogUtils.dart';
import 'package:jdshop/utils/ScreenUtils.dart';

/// 主框架 Tabs的切换

class HomePages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePagesState();
  }
}

class HomePagesState extends State<HomePages> with AutomaticKeepAliveClientMixin {
  List _focusData = [];
  List _hotlist = [];
  List _bestProductList = [];

  //定义方法抽取swper组件
  Widget _swiperWidget() {
    if (this._focusData.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = this._focusData[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return new Image.network(
                "$pic",
                fit: BoxFit.fill,
              );
            },
            itemCount: this._focusData.length,
            pagination: new SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Text("错误");
    }
  }

  //标题组件的封装
  Widget _titileWidget(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtils.width(5), 0, 0, 0),
      margin: EdgeInsets.only(
          left: ScreenUtils.width(5), top: ScreenUtils.width(5)),
      child: Text(
        title,
        style: TextStyle(color: Colors.black54),
      ),
      decoration: BoxDecoration(
          border: Border(
              left:
                  BorderSide(color: Colors.red, width: ScreenUtils.width(5)))),
    );
  }

  //猜你喜欢组件的封装
  // ignore: non_constant_identifier_names
  Widget _HotWidget() {
    //ListView 不能嵌套 解决办法 外侧加Container
    if (this._hotlist.length > 0) {
      return Container(
        height: ScreenUtils.height(234),
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            String sPic = this._hotlist[index].sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Container(
                  height: ScreenUtils.height(140),
                  width: ScreenUtils.width(140),
                  margin: EdgeInsets.only(right: ScreenUtils.width(21)),
                  child: Image.network(sPic, fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenUtils.height(10)),
                  height: ScreenUtils.height(44),
                  child: Text(
                    "¥${this._hotlist[index].price}",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: this._hotlist.length,
        ),
      );
    } else {
      return Text("正在====");
    }
  }

//推荐

  //热门商品

  //推荐商品
  Widget _recProductListWidget() {

    var itemWidth = (ScreenUtils.getScreenWidth() - 30) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this._bestProductList.map((value) {

          //图片
          String sPic=value.sPic;
          sPic=Config.domain+sPic.replaceAll('\\', '/');
          LogUtils.e("aaa", sPic);

          return Container(
            padding: EdgeInsets.all(10),
            width: itemWidth,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: AspectRatio(
                    //防止服务器返回的图片大小不一致导致高度不一致问题
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      "$sPic",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtils.height(20)),
                  child: Text(
                    "${value.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtils.height(20)),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "¥${value.price}",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text( "¥${value.oldPrice}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough)),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  //导航页面的数据请求

  _getFocus() async {
    var url = "${Config.domain}api/focus";
    var res = await Dio().get(url);
    var listdata = FocusModel.fromJson(res.data);
    //
    setState(() {
      this._focusData = listdata.result;
    });
  }

  //获取猜你喜欢的数据
  _getCai() async {
    var api = '${Config.domain}api/plist?is_hot=1';

    var res = await Dio().get(api);

    var hotdata = ProducModel.fromJson(res.data);

    setState(() {
      this._hotlist = hotdata.result;
    });
  }

  //获取热门推荐的数据
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
     var bestProductList =ProducHotModel.fromJson(result.data);
    setState(() {
      this._bestProductList = bestProductList.result;

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getFocus();
    this._getCai();
    this._getBestProductData();
  }

  @override
  Widget build(BuildContext context) {
    //屏幕适配
    ScreenUtils.init(context);

    return ListView(
      children: <Widget>[
        //轮播图
        _swiperWidget(),
        SizedBox(
          height: ScreenUtils.height(10),
        ),
        //热门推荐
        _titileWidget("猜你喜欢"),
        SizedBox(
          height: ScreenUtils.height(10),
        ),
        _HotWidget(),
        SizedBox(
          height: ScreenUtils.height(10),
        ),
        _titileWidget("热门推荐"),
        _recProductListWidget()
      ],
    );
  }

  @override
  // 保持页面状态 数据不重新加载
  bool get wantKeepAlive => true;
}
