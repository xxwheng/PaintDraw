import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/* 姓名 认证图片 */
class YuesaoNameAuthWidget extends StatelessWidget {

  final String nickname;
  final bool isCredit;

  YuesaoNameAuthWidget({Key key, this.nickname, this.isCredit}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          nickname,
          style: TextStyle(
              fontSize: AdaptUI.rpx(32)),
        ),
        isCredit ? Row(children: [
          Container(
              padding: EdgeInsets.only(left: AdaptUI.rpx(20)),
              width: AdaptUI.rpx(50),
              height: AdaptUI.rpx(50),
              child: Image(image: AssetImage("images/ys_auth.png"), fit: BoxFit.fitWidth,)
          ),
          Text("家家母婴学院认证", style: TextStyle(color: UIColor.mainColor, fontSize: AdaptUI.rpx(24)),),
        ],) : Offstage()

      ],
    );
  }
}
