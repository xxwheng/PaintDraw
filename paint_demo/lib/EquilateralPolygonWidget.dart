import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/* 规则等边多边形 */
class EquilateralPolygonWidget extends StatelessWidget {
  /* n边形 */
  final int sideNum;
  /* 整体控件大小 */
  final double size;
  /* 填充颜色 */
  final Color color;
  /* 顶点开始方位 1 顶部 、  2 右边  、  3 下边  、  4 左边 */
  final int startIndex;

  EquilateralPolygonWidget({Key key, this.sideNum, this.size, this.color, this.startIndex}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(375, 375),
      painter: EquilateralPolygonPainter(
          sideNum: sideNum == null || sideNum < 3 ? 3 : sideNum,
          width: size ?? 100,
          fillColor: color ?? Colors.red,
          beginPoint: this.startIndex ?? 1
      ),
    );
  }
}

/* 等边多边形绘制 */
class EquilateralPolygonPainter extends CustomPainter {

  EquilateralPolygonPainter({Key key, this.sideNum, this.width, this.fillColor, this.beginPoint});

  /* 整体宽高 */
  double width;

  /* 几边形 */
  int sideNum;

  /* 填充颜色 */
  Color fillColor;

  /* 方位 1 顶部 、  2 右边  、  3 下边  、  4 左边  */
  int beginPoint;

  /* 每一边对应的角度角度 */
  double _angle;

  /* 半径 */
  double _r;

  /* 画笔 */
  Paint _paint;


  /* 初始化数据 */
  void initData() {
    _angle = 360.0 / sideNum;
    _r = width / 2;
    _paint = Paint();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    initData();
    drawPathFilled(canvas);
  }

  /* 绘制路径 并填充 */
  void drawPathFilled(Canvas canvas) {
    _paint.color = fillColor;
    _paint.isAntiAlias = true;
    _paint.strokeWidth = 1;
    _paint.style = PaintingStyle.fill;

    var _path = Path();
    // 1 顶部 、  2 右边  、  3 下边  、  4 左边
    switch (beginPoint) {
      case 1: _path.moveTo(_r, 0); break;
      case 2: _path.moveTo(_r*2, _r); break;
      case 3: _path.moveTo(_r, _r*2); break;
      case 4: _path.moveTo(0, _r); break;
      default: _path.moveTo(_r, 0); break;
    }
    if (beginPoint == 1) {

    } else if (beginPoint == 2) {

    } else if (beginPoint == 3 ) {

    } else {

    }

    this.circleSidePoints(beginPoint).forEach((element) {
      _path.lineTo(element.dx, element.dy);
    });
    _path.close();
    canvas.drawPath(_path, _paint);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

  /* 边上顶点列表
  *
  *   index: 从那个方位开始（默认1 顶部）
  *   1 顶部 、  2 右边  、  3 下边  、  4 左边
  *   return: 边上顶点列表（Offset）
  * */
  List<Offset> circleSidePoints(int index) {
    List<Offset> list= [];
    for (var i = 0; i < sideNum; i++) {
      Offset point;
      switch (index) {
        case 1:
          point = Offset(_r + sin(angleSp(i)) * _r, _r - cos(angleSp(i)) * _r);
          break;
        case 2:
          point = Offset(_r + cos(angleSp(i)) * _r, _r + sin(angleSp(i)) * _r);
          break;
        case 3:
          point = Offset(_r - sin(angleSp(i)) * _r, _r + cos(angleSp(i)) * _r);
          break;
        case 4:
          point = Offset(_r - cos(angleSp(i)) * _r, _r - sin(angleSp(i)) * _r);
          break;
        default: point = Offset(_r + sin(angleSp(i)) * _r, _r - cos(angleSp(i)) * _r);
      }
      list.add(point);
    }
    return list;
  }

  /* 计算角度 */
  double angleSp(int i) {
    return _angle * i * (pi / 180);
  }
}
