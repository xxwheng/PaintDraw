import 'dart:ui';

import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/* 月嫂列表筛选 选择栏 */
// ignore: must_be_immutable
class YsFilterPickerRowWidget extends StatelessWidget {

  double height = AdaptUI.rpx(80);

  Color rowColor = Colors.white;

  String title;

  String hintText;

  String content;

  GestureTapUpCallback tapAction;

  YsFilterPickerRowWidget({Key key, this.height, this.title, this.hintText, this.content, this.tapAction}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: AdaptUI.rpx(30)),
      height: height,

      decoration: BoxDecoration(
        color: rowColor,
          border: Border(
              bottom: BorderSide(
                  color: UIColor.hexEEE, width: 0.5))),
      child: GestureDetector(
        onTapUp: tapAction,
        child: Container(
          padding: EdgeInsets.only(right: AdaptUI.rpx(30)),

          child: Row(
            children: [
              Container(
                width: AdaptUI.rpx(150),
                child: Text(
                  title,
                  style: TextStyle(fontSize: AdaptUI.rpx(30)),
                ),
              ),
              Expanded(

                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    controller: TextEditingController(text: content),
                    readOnly: true,
                    enabled: false,
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
      labelStyle: TextStyle(fontSize: AdaptUI.rpx(30)),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: hintText,
                    hintStyle: TextStyle(fontSize: AdaptUI.rpx(30))),
                  )),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: AdaptUI.rpx(30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
