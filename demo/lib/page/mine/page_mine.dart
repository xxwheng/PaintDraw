import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/page/root/app.dart';
import 'package:flutter/material.dart';

/// 我的-tab
class PageMine extends StatefulWidget {
  @override
  _PageMineState createState() => _PageMineState();
}

class _PageMineState extends State<PageMine> {
  final List<String> menuList = ["我的优惠券", "我的关注", "分享应用", "专属服务", "关于"];
  final List<Widget> leadIcons = [
    Icon(Icons.flag, color: UIColor.hex666),
    Icon(Icons.star, color: UIColor.hex666),
    Icon(Icons.share, color: UIColor.hex666),
    Icon(Icons.call, color: UIColor.hex666),
    Icon(Icons.privacy_tip_outlined, color: UIColor.hex666)
  ];

  /// 点击
  void itemDidTapIndex(int index) {
    switch (index) {
      case 1:
        App.navigationTo(context, PageRoutes.myCollect);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("家家月嫂")),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: UIColor.mainColor,
              padding: EdgeInsets.only(
                  top: AdaptUI.rpx(60), bottom: AdaptUI.rpx(50)),
              child: Column(
                children: [
                  ClipOval(
                      child: Image.asset("images/image01.jpg",
                          fit: BoxFit.cover,
                          width: AdaptUI.rpx(180),
                          height: AdaptUI.rpx(180))),
                  Container(
                    margin: EdgeInsets.only(top: AdaptUI.rpx(40)),
                    child: Center(
                      child: Text(
                        "师会敏",
                        style: TextStyle(
                          fontSize: AdaptUI.rpx(34),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
            ),
            ...menuList
                .asMap()
                .keys
                .map((index) => Container(
                      padding: EdgeInsets.only(
                          left: AdaptUI.rpx(30), right: AdaptUI.rpx(25)),
                      height: AdaptUI.rpx(90),
                      child: GestureDetector(
                        onTapUp: (tap) => this.itemDidTapIndex(index),
                        child: Row(
                          children: [
                            leadIcons[index],
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.only(left: AdaptUI.rpx(10)),
                              child: Text(
                                menuList[index],
                                style: TextStyle(
                                    fontSize: AdaptUI.rpx(30),
                                    color: UIColor.hex333),
                              ),
                            )),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: AdaptUI.rpx(30),
                              color: UIColor.hex999,
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
