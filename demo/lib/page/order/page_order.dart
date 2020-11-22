import 'package:flutter/material.dart';


/// 订单-tab
class PageOrder extends StatefulWidget {
  @override
  _PageOrderState createState() => _PageOrderState();
}

class _PageOrderState extends State<PageOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("订单"),
        ),
        elevation: 0,
      ),
    );
  }
}
