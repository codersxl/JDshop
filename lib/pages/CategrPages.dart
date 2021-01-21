import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/utils/ScreenUtils.dart';

/// 主框架 Tabs的切换

class CategrPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategrPagesState();
  }
}

class CategrPagesState extends State {
  //计算右侧的宽高比

  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(context);
    var leftwidth = ScreenUtils.getScreenWidth() / 4;
    var rithwidth = (ScreenUtils.getScreenWidth() - leftwidth - 20 - 20) / 3;
    rithwidth = ScreenUtils.width(rithwidth);
    var rightHeight = rithwidth + ScreenUtils.height(28);

    return Row(
      children: <Widget>[
        //左侧的页面
        Container(
            width: leftwidth,
            height: double.infinity,
            child: ListView.builder(
                itemCount: 40,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            this.selectedItem = index;
                          });
                        },
                        child: Container(
                          color: this.selectedItem == index
                              ? Colors.red
                              : Colors.white,
                          child: Text(
                            "第$index条",
                            textAlign: TextAlign.center,
                          ),
                          width: double.infinity,
                          height: ScreenUtils.height(84),
                          padding: EdgeInsets.only(top: ScreenUtils.height(10)),
                        ),
                      ),
                      Divider(
                        height: 1,
                      )
                    ],
                  );
                })),
        //右侧
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Color.fromRGBO(240, 246, 246, 0.9),
            height: double.infinity,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: rithwidth / rightHeight,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            "https://www.itying.com/images/flutter/slide01.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          height: ScreenUtils.height(28),
                          child: Text("女装"),
                        )
                      ],
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
