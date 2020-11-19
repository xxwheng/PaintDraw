import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/// 文章搜索点击
class ArticleSearchWidget extends StatelessWidget {

  final VoidCallback tap;

  ArticleSearchWidget({Key key, this.tap}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.tap,
      child: Container(
        margin: EdgeInsets.fromLTRB(AdaptUI.rpx(30),AdaptUI.rpx(20),AdaptUI.rpx(30),AdaptUI.rpx(20)),
        height: AdaptUI.rpx(80),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(AdaptUI.rpx(40))),
            border: Border.all(color: UIColor.hexEEE)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 4),
              child: Icon(Icons.search, size: AdaptUI.rpx(40),color: UIColor.mainColor,),
            ),
            Text("搜索海量孕育知识", style: TextStyle(color: UIColor.hex666),)
          ],
        ),
      ),
    );
  }
}
