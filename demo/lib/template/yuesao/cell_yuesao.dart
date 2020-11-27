import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/model/ys_item_bean.dart';
import 'package:flutter/material.dart';

import 'package:demo/slice/ys_head_level.dart';
import 'package:demo/slice/ys_name_auth.dart';

class CellYuesao extends StatelessWidget {
  /// 1 月嫂  2育婴师
  final int type;
  final String headPhoto;
  final bool isCredit;
  final String level;
  final String careType;
  final String nickName;
  final String desc;
  final String score;
  final String price;
  final String service;
  final bool showCancel;
  final VoidCallback cancelTap;

  CellYuesao(
      {Key key,
      this.type = 1,
      this.headPhoto,
      this.isCredit,
      this.level,
      this.careType,
      this.nickName,
      this.desc,
      this.score,
      this.price,
      this.service,
      this.showCancel = true,
      this.cancelTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AdaptUI.rpx(320),
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              YuesaoHeadLevelWidget(
                headUrl: headPhoto,
                level: level,
                type: type,
                careType: careType,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: AdaptUI.rpx(30), left: AdaptUI.rpx(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          YuesaoNameAuthWidget(
                            nickname: nickName,
                            isCredit: isCredit,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: AdaptUI.rpx(10)),
                            padding: EdgeInsets.only(right: AdaptUI.rpx(100)),
                            child: Text(
                              desc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: AdaptUI.rpx(30)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: AdaptUI.rpx(30),
                      width: AdaptUI.rpx(70),
                      height: AdaptUI.rpx(90),
                      child: Container(
                        padding: EdgeInsets.only(top: AdaptUI.rpx(10)),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/ys_score.png"))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: AdaptUI.rpx(28)),
                              child: Text("$score分",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AdaptUI.rpx(18))),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: AdaptUI.rpx(30),
                      bottom: AdaptUI.rpx(30),
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  TextSpan(
                                      text: "￥",
                                      style: TextStyle(
                                          color: UIColor.fontLevel,
                                          fontSize: AdaptUI.rpx(24))),
                                  TextSpan(
                                      text: "$price",
                                      style: TextStyle(
                                          color: UIColor.fontLevel,
                                          fontSize: AdaptUI.rpx(34),
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                      text: type == 1 ? "/$service天" : "/月",
                                      style: TextStyle(
                                          fontSize: AdaptUI.rpx(24),
                                          color: UIColor.hex333)),
                                ]),
                          ),
                          showCancel
                              ? InkWell(
                                  onTap: this.cancelTap,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: AdaptUI.rpx(20)),
                                    width: AdaptUI.rpx(140),
                                    height: AdaptUI.rpx(44),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: UIColor.hex999),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(AdaptUI.rpx(22)))),
                                    child: Text(
                                      "取消关注",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: AdaptUI.rpx(25),
                                          color: UIColor.mainColor),
                                    ),
                                  ),
                                )
                              : Offstage(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
