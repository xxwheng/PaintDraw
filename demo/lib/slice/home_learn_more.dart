import 'package:adaptui/adaptui.dart';
import 'package:flutter/material.dart';

import '../common/color.dart';
import '../common/color.dart';

/// 首页-了解更多头部栏
class HomeLearnMoreHeaderWidget extends StatelessWidget {

  final String title;
  final EdgeInsetsGeometry margin;
  final GestureTapCallback tap;

  HomeLearnMoreHeaderWidget({Key key, this.margin,  @required this.title, this.tap}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: AdaptUI.rpx(80),
      padding: EdgeInsets.only(left: AdaptUI.rpx(30), right: AdaptUI.rpx(30)),
      child: Row(
        children: <Widget>[
          Container(margin: EdgeInsets.only(right: 5), width: AdaptUI.rpx(8), height: AdaptUI.rpx(35),color: UIColor.mainColor,),
          Expanded(child: Text(title, style: TextStyle(fontSize: AdaptUI.rpx(32), fontWeight: FontWeight.bold),)),
          GestureDetector(
            onTap: tap,
            child: Row(
              children: <Widget>[
                Text("了解更多", style: TextStyle(color: UIColor.hex999),),
                Image.asset("images/arrow_next.png", width: AdaptUI.rpx(30),height: AdaptUI.rpx(30),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
