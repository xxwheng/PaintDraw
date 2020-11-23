import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/tab_bar.dart';
import 'package:demo/template/yuesao/collect_ys_tabview.dart';
import 'package:flutter/material.dart';

/// 月嫂、育婴师关注
class YsCollectPage extends StatefulWidget {
  @override
  _YsCollectPageState createState() => _YsCollectPageState();
}

class _YsCollectPageState extends State<YsCollectPage> {
  final List<String> navList = ["月嫂", "育婴师"];
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        TabController(length: navList.length, vsync: ScrollableState());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的关注"),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: AdaptUI.screenWidth,
              height: AdaptUI.rpx(100),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
              child: TabBar(
                controller: _controller,
                indicatorColor: UIColor.mainColor,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: UIColor.hex333,
                unselectedLabelStyle: TextStyle(
                    fontSize: AdaptUI.rpx(28), fontWeight: FontWeight.normal),
                labelColor: UIColor.mainColor,
                labelStyle: TextStyle(
                    fontSize: AdaptUI.rpx(32), fontWeight: FontWeight.bold),
                tabs: navList.map((e) => Tab(text: e,)).toList(),
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: _controller,
              children:
                  navList.asMap().keys.map((e) => CollectYsTabView()).toList(),
            ))
          ],
        ),
      ),
    );
  }
}
