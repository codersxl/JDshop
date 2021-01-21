import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jdshop/utils/ScreenUtils.dart';

/// 主框架 Tabs的切换

class HomePages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePagesState();
  }
}

class HomePagesState extends State {
  //定义方法抽取swper组件
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    ];

    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              imgList[index]["url"],
              fit: BoxFit.fill,
            );
          },
          itemCount: imgList.length,
          pagination: new SwiperPagination(),
          autoplay: true,
        ),
      ),
    );
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

  //热门组件的封装
  Widget _HotWidget() {
    //ListView 不能嵌套 解决办法 外侧加Container
    return Container(
      height: ScreenUtils.height(234),
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              //图片
              Container(
                height: ScreenUtils.height(140),
                width: ScreenUtils.width(140),
                margin: EdgeInsets.only(right: ScreenUtils.width(21)),
                child: Image.network("https://www.itying.com/images/flutter/hot${index+1}.jpg",fit: BoxFit.cover),
              ),
              Container(
                padding: EdgeInsets.only(top:ScreenUtils.height(10)),
                height: ScreenUtils.height(44),
                child: Text("第${index}条"),
              )
              
            ],
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //屏幕适配
    ScreenUtils.init(context);

    return ListView(
      children: <Widget>[
        //轮播图
        _swiperWidget(),
        SizedBox(height: ScreenUtils.height(10),),
        //热门推荐
        _titileWidget("猜你喜欢"),
        SizedBox(height: ScreenUtils.height(10),),
        _HotWidget(),
        SizedBox(height: ScreenUtils.height(10),),
        _titileWidget("热门推荐")
      ],
    );
  }
}
