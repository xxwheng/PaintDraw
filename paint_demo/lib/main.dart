import 'package:flutter/material.dart';
import 'package:paint_demo/EquilateralPolygonWidget.dart';
import 'package:paint_demo/IrregularPolygonWidget.dart';
import 'package:paint_demo/ys_value_pie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("绘制"),),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              width: 300,
                height: 300,
              child: YsValuePieWidget(
                color: Color.fromARGB(255, 180, 80, 220),
                size: 300,
                startIndex: 1,
                sideNum: 16,
                values:
                [
                  0.75,0.75,0.75,0.70,
                  0.75,0.75,0.75,0.75,
                  0.80,0.75,0.75,0.75,
                  0.75,0.75,0.75,0.75
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}

