import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/// 首页月嫂之星cell
class HomeYuesaoTopWidget extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final String imageUrl;
  final String name;
  final String levelStr;

  HomeYuesaoTopWidget(
      {Key key, this.margin, this.imageUrl, this.name, this.levelStr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AdaptUI.rpx(260),
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: UIColor.hexEEE, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 5,
                spreadRadius: 1,
                color: Color.fromRGBO(221, 221, 221, 0.4))
          ],
      ),
      child: Column(
        children: [
          Container(
            width: AdaptUI.rpx(260),
            height: AdaptUI.rpx(260),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: AdaptUI.rpx(20)),
            child: Center(
              child: Text(name),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: AdaptUI.rpx(10)),
            child: Center(
              child: Text(
                levelStr,
                style: TextStyle(
                    fontSize: AdaptUI.rpx(32),
                    fontWeight: FontWeight.bold,
                    color: UIColor.fontLevel),
              ),
            ),
          )
        ],
      ),
    );
  }
}
