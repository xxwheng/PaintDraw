import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/utils/ys_level.dart';
import 'package:flutter/material.dart';

/* 月嫂头像 等级 */
class YuesaoHeadLevelWidget extends StatelessWidget {
  String headUrl;
  String level;
  YuesaoHeadLevelWidget({Key key, @required this.headUrl, @required this.level}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(AdaptUI.rpx(8)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xffcc99cc), width: 1),
          ),
          child: Container(
            width: AdaptUI.rpx(140),
            height: AdaptUI.rpx(140),
            child: ClipOval(
              child: headUrl.isNotEmpty ? CachedNetworkImage(
                imageUrl: headUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image(image: AssetImage("images/place_head.png")),
              ) : Image(image: AssetImage("images/place_head.png")),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xffcc99cc), width: 1),
            ),
          ),
        ),
        Opacity(opacity: 0.7, child: Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(12)),
          width: AdaptUI.rpx(12),
          height: AdaptUI.rpx(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffcc3399),
          ),
        ),),
        Opacity(opacity: 0.5, child: Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(8)),
          width: AdaptUI.rpx(10),
          height: AdaptUI.rpx(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffcc3399),
          ),
        ),),
        Opacity(opacity: 0.3, child: Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(8)),
          width: AdaptUI.rpx(8),
          height: AdaptUI.rpx(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffcc3399),
          ),
        ),),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(10)),
          child: Text(
            YsLevel.getYuesaoLevel(level),
            style: TextStyle(fontSize: AdaptUI.rpx(28), fontWeight: FontWeight.w500, color: Color(0xffcc3399)),
          ),
        )
      ],
    );
  }
}