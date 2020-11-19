import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 首页 评价
class HomeCommentWidget extends StatelessWidget {

  final String headPhoto;
  final String username;
  final int score;
  final String createTime;
  final String serverDays;
  final String content;
  final List<String> picList;

  HomeCommentWidget({Key key, this.headPhoto, this.username, this.score, this.createTime, this.serverDays, this.content, this.picList}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(AdaptUI.rpx(20), AdaptUI.rpx(20), 0, AdaptUI.rpx(20)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: AdaptUI.rpx(90),
                height: AdaptUI.rpx(90),
                margin: EdgeInsets.only(right: AdaptUI.rpx(15)),
                child: ClipOval(
                  child: CachedNetworkImage(imageUrl: headPhoto, fit: BoxFit.cover,),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(username, style: TextStyle(fontSize: AdaptUI.rpx(32),),),
                      Container(width: AdaptUI.rpx(30),),
                      ...List.generate(score, (index) {
                        return  Container(margin: EdgeInsets.only(left: 2) , width: AdaptUI.rpx(26), height: AdaptUI.rpx(26),
                          child: Image.asset( "images/ys_heart.png", fit: BoxFit.fitWidth,),
                        );
                      }).toList(),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text("$score分")
                      )

                    ],
                  ),
                  Text("$createTime 服务$serverDays天")
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
            child: Text(content, style: TextStyle(),),
          ),
          Row(
            children: picList.asMap().keys.map((index) {
              if (index > 2) { return Offstage(); }
              return Container(
                margin: EdgeInsets.only(top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
                width: AdaptUI.rpx(202),
                height: AdaptUI.rpx(202),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(AdaptUI.rpx(10)))
                ),
                // child: CachedNetworkImage(imageUrl: e, fit: BoxFit.cover,),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
