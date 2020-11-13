import 'package:adaptui/adaptui.dart';
import 'package:demo/model/ys_item_bean.dart';
import 'package:flutter/material.dart';

import 'package:demo/slice/ys_head_level.dart';
import 'package:demo/slice/ys_name_auth.dart';

class CellYuesao extends StatelessWidget {

  YsItemBean ysItemBean;

  CellYuesao({Key key, this.ysItemBean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AdaptUI.rpx(320),
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              YuesaoHeadLevelWidget(headUrl: ysItemBean.headPhoto, level: ysItemBean.level,),
              Expanded(
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: AdaptUI.rpx(30), left: AdaptUI.rpx(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            YuesaoNameAuthWidget(nickname: ysItemBean.nickname,),
                            Container(
                              margin: EdgeInsets.only(top: AdaptUI.rpx(10)),
                              padding: EdgeInsets.only(right: AdaptUI.rpx(100)),
                              child: Text(
                                ysItemBean.desc,
                                maxLines: 2,
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
                          decoration:
                          BoxDecoration(color: Colors.deepOrangeAccent),
                          child: Column(
                            children: [
                              Image.asset(
                                "images/image01.jpg",
                                width: AdaptUI.rpx(30),
                                height: AdaptUI.rpx(30),
                                fit: BoxFit.cover,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: AdaptUI.rpx(6)),
                                child: Text("${ysItemBean.scoreComment}分",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white, fontSize: AdaptUI.rpx(18))),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right: AdaptUI.rpx(30), bottom: AdaptUI.rpx(30), child: RichText(text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                                text: "￥", style: TextStyle(color: Colors.red, fontSize: AdaptUI.rpx(28))
                            ),
                            TextSpan(
                                text: "${ysItemBean.price}", style: TextStyle(color: Colors.red, fontSize: AdaptUI.rpx(32))
                            ),
                            TextSpan(
                                text: "/${ysItemBean.service}天", style: TextStyle(fontSize: AdaptUI.rpx(28))
                            ),
                          ]
                      )))
                    ],
                  ))
            ],
          ),
        ));
  }
}
