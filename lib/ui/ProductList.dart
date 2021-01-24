import 'package:flutter/material.dart';
import 'package:jdshop/utils/ScreenUtils.dart';

// ignore: must_be_immutable
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
  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("sd"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            //每一个元素
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtils.width(180),
                      height: ScreenUtils.height(180),
                      child: Image.network(
                          "https://www.itying.com/images/flutter/list2.jpg",
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
                                "戴尔(DELL)灵越3670 英特尔酷睿i5 高性能 台式电脑整机(九代i5-9400 8G 256G)",
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
                              "¥990",
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
          itemCount: 10,
        ),
      ),
    );
  }
}
