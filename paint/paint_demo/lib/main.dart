import 'package:flutter/material.dart';
import 'package:paint_demo/EquilateralPolygonWidget.dart';

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
        child: SizedBox(
          width: 300,
          height: 300,
          child: EquilateralPolygonWidget(
            color: Colors.blue,
            size: 300,
            sideNum: 5,
          ),
        ),
      ),
    );
  }
}

