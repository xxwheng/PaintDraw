
import 'package:adaptui/adaptui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIColor {

  static const Color themeColor = Color.fromARGB(255, 121, 36, 189);
  
  static const Color mainColor = Color.fromRGBO(126, 27, 195, 1);

  // 页面背景色f8
  static const Color pageColor = Color(0xfff8f8f8);

  // 字体颜色

  static const Color hex333 = Color(0xff333333);

  static const Color hex666 = Color(0xff666666);

  static const Color hex999 = Color(0xff999999);

  // 字体星级颜色
  static const Color fontLevel = Color(0xffcc3399);

  // 分割线、下划线
  static const Color hexEEE = Color(0xffe5e5e5);

}

class UITextStyle {
  static TextStyle normal({double size = 14, Color color = UIColor.hex333, FontWeight weight = FontWeight.normal}) {
    return TextStyle(fontSize: size, color: color, fontWeight: weight);
  }
}