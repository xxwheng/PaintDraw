
import 'package:adaptui/adaptui.dart';
import 'package:flutter/cupertino.dart';

class UIColor {

  static const Color themeColor = Color.fromARGB(255, 121, 36, 189);
  
  static const Color mainColor = Color.fromRGBO(126, 27, 195, 1);

  // 字体颜色
  static const Color hex333 = Color(0xff333333);

  // 分割线、下划线
  static const Color hexEEE = Color(0xffe5e5e5);

}

class UITextStyle {
  static TextStyle normal({double size = 14, Color color = UIColor.hex333, FontWeight weight = FontWeight.normal}) {
    return TextStyle(fontSize: size, color: color, fontWeight: weight);
  }
}