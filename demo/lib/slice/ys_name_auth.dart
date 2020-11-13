import 'package:adaptui/adaptui.dart';
import 'package:flutter/material.dart';

/* 姓名 认证图片 */
class YuesaoNameAuthWidget extends StatelessWidget {

  String nickname;

  YuesaoNameAuthWidget({Key key, this.nickname}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          nickname,
          style: TextStyle(
              fontSize: AdaptUI.rpx(32)),
        ),
        Container(
          padding: EdgeInsets.only(left: AdaptUI.rpx(20)),
          width: AdaptUI.rpx(160),
          height: AdaptUI.rpx(24),
          child: Image(image: AssetImage("images/honour.png"), fit: BoxFit.contain,)
        )
      ],
    );
  }
}
