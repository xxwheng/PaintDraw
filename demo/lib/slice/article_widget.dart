import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 文章单项widget
class ArticleWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final VoidCallback tap;

  ArticleWidget({Key key, this.imageUrl, this.title, this.desc, this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: this.tap,
        child: Container(
          padding: EdgeInsets.fromLTRB(AdaptUI.rpx(30), AdaptUI.rpx(20),
              AdaptUI.rpx(30), AdaptUI.rpx(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: AdaptUI.rpx(18)),
                width: AdaptUI.rpx(150),
                height: AdaptUI.rpx(150),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: AdaptUI.rpx(30),
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: AdaptUI.rpx(18)),
                      child: Text(
                        desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}
