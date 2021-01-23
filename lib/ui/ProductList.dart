import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/config/Config.dart';
import 'package:jdshop/model/ProducModel.dart';
import 'package:jdshop/model/ProductListModel.dart';
import 'package:jdshop/utils/LoadingWidget.dart';
import 'package:jdshop/utils/ScreenUtils.dart';

class ProductList extends StatefulWidget {
  Map arguments;

  ProductList({Key key, this.arguments}) {}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductListState();
  }
}

class ProductListState extends State<ProductList> {

  //用于上拉分页
  ScrollController _scrollController = ScrollController(); //listview 的控制器

  //分页
  int _page = 1;

  //每页有多少条数据
  int _pageSize=8;

  //数据
  List _productList = [];
  /*
  排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  */
  String _sort = "";

  //解决重复请求的问题
  bool flag=true;

  //是否有数据

  bool _hasMore=true;

  //定义事件 打开抽屉
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _getListView(){
    // Padding(
    //   padding: EdgeInsets.all(10),
    //   child: ,
    // );
     if(this._productList.length>0){
       return Container(
         padding: EdgeInsets.only(top: ScreenUtils.height(10)),
         margin: EdgeInsets.only(top: ScreenUtils.height(80)),
         child: ListView.builder(
           itemBuilder: (context, index) {
             String pic=this._productList[index].pic;
             pic=Config.domain+pic.replaceAll('\\', '/');
             //每一个元素
             return Column(
               children: <Widget>[
                 Row(
                   children: <Widget>[
                     Container(
                       width: ScreenUtils.width(180),
                       height: ScreenUtils.height(180),
                       child: Image.network(
                           pic,
                           fit: BoxFit.cover),
                     ),
                     Expanded(
                       flex: 1,
                       child: Container(
                         height: ScreenUtils.height(180),
                         margin: EdgeInsets.only(left: 10),
                         // color: Colors.red,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             Text(
                                 "${this._productList[index].title}",
                                 maxLines: 2,
                                 overflow: TextOverflow.ellipsis),
                             Row(
                               children: <Widget>[
                                 Container(
                                   height: ScreenUtils.height(36),
                                   margin: EdgeInsets.only(right: 10),
                                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                                   //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: Color.fromRGBO(230, 230, 230, 0.9),
                                   ),

                                   child: Text("4g"),
                                 ),
                                 Container(
                                   height: ScreenUtils.height(36),
                                   margin: EdgeInsets.only(right: 10),
                                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: Color.fromRGBO(230, 230, 230, 0.9),
                                   ),
                                   child: Text("126"),
                                 ),
                               ],
                             ),
                             Text(
                               "¥${this._productList[index].price}",
                               style: TextStyle(color: Colors.red, fontSize: 16),
                             )
                           ],
                         ),
                       ),
                     )
                   ],
                 ),
                 Divider(height: 20)
               ],
             );
           },
           itemCount: this._productList.length,
         ),
       );
     }else{
       return LoadingWidget();
     }

  }

 //
  Widget _getSubview(){
    return  Positioned(
      width: ScreenUtils.width(750),
      height: ScreenUtils.height(80),
      child:Container(
        width: ScreenUtils.width(750),
        height: ScreenUtils.height(80),
        decoration: BoxDecoration(
            border: Border(
                bottom:BorderSide(
                    width: 1,
                    color: Color.fromRGBO(233, 233, 233, 0.9)
                )
            )
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,

              child: InkWell(
                onTap: (){

                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0,ScreenUtils.height(16),0,ScreenUtils.height(16)),
                  child: Text("综合",textAlign: TextAlign.center,),
                ),
              ),

            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: (){

                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0,ScreenUtils.height(16),0,ScreenUtils.height(16)),
                  child: Text("销量",textAlign: TextAlign.center,),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: (){

                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0,ScreenUtils.height(16),0,ScreenUtils.height(16)),
                  child: Text("价格",textAlign: TextAlign.center,),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: (){
                  _scaffoldKey.currentState.openEndDrawer();
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0,ScreenUtils.height(16),0,ScreenUtils.height(16)),
                  child: Text("筛选",textAlign: TextAlign.center,),
                ),
              ),
            ),
          ],
        ),
      ) ,
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  //请求数据
  _getData() async{

    var api ='${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';

       var res= await Dio().get(api);
         var producModel = ProductListModel.fromJson(res.data);
         setState(() {
              this._productList.addAll(producModel.result);
              print("aaa${this._productList.toString()}");
         });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(context);
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(

        child: Container(
          child: Text("=="),
        ),
      ),
      appBar: AppBar(
        title: Text("sd"),
        actions: <Widget>[
          Text("")//去除抽屉图片
        ],
      ),
      body: Stack(
        children: <Widget>[
          _getListView(),
          _getSubview()
        ],
      ),


    );
  }
}
