import 'dart:ui';
import 'package:flutter/material.dart';

typedef IndexedMenuWidgetBuiler = Widget Function(BuildContext context, int index, double width, double height);


// ignore: must_be_immutable
/// 首页菜单栏
class MenuScrollWidget extends StatefulWidget {
  final List<String> menuList;

  final IndexedWidgetBuilder builer;

  MenuScrollWidget({Key key,  @required this.menuList, @required this.builer}) : super(key: key);

  @override
  _MenuScrollWidgetState createState() => _MenuScrollWidgetState();

}

class _MenuScrollWidgetState extends State<MenuScrollWidget> {
  /// 一行5个
  static int _rowNums = 5;
  static double _screenWidth = MediaQueryData.fromWindow(window).size.width;
  final double _itemWidth = _screenWidth / _rowNums;
  final double _rowHeight = _screenWidth / _rowNums;

  /// 第一页数据
  List<String> firstList;

  /// 第二页数据
  List<String> lastList;

  List<List<String>> _menuList;

  /// 整体高度(最高高度)
  double _sectionHeight = 0;

  PageController _controller;

  /// 初始高度（第一页高度）
  double _oriH = 0;

  /// 底部视图距离底部高度
  double _marginTop = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController();
    _controller.addListener(() {
      this.scrollDidChanged();
    });
    readyWidgetFrame();
  }

  void readyWidgetFrame() {
    if (widget.menuList.length > _rowNums * 2) {
      /// 超出一页（两页，第二页展示全部）
      if (widget.menuList.length > _rowNums * 4) {
        /// 第二页比第一页多
        _sectionHeight =
            _rowHeight * ((widget.menuList.length - _rowNums * 2) / 5.0).ceil();
      } else {
        _sectionHeight = _rowHeight * 2;
      }

      firstList = widget.menuList.sublist(0, 10);
      lastList = widget.menuList.sublist(10);
      _menuList = [firstList, lastList];
      _oriH = _rowHeight * 2;
      _marginTop = _rowHeight * 2;
    } else {
      firstList = widget.menuList;
      _sectionHeight = _rowHeight * (widget.menuList.length / 5.0).ceil();
      _menuList = [firstList];
      _oriH = _sectionHeight;
      _marginTop = _sectionHeight;
    }
  }



  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("menu_didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant MenuScrollWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("menu_didUpdateWidget");
    readyWidgetFrame();
  }

  /// 滚动
  void scrollDidChanged() {
    var rateH = _controller.offset / _screenWidth;
    var spaceH = _sectionHeight - _oriH;
    var top = rateH * spaceH + _oriH;
    if (top < _oriH) {
      top = _oriH;
    }
    if (top > _sectionHeight) {
      top = _sectionHeight;
    }
    if (this._marginTop == top) {
      return;
    }
    setState(() {
      this._marginTop = top;
    });
  }

  @override
  Widget build(BuildContext context) {

    print("menu_build");
    return widget.menuList == null || widget.menuList.isEmpty
        ? Container()
        : Container(
            height: _marginTop,
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: this._sectionHeight,
                    child: Container(
                      height: this._sectionHeight,
                      child: PageView(
                          controller: _controller,
                          children: _menuList?.asMap()?.keys?.map((section) {
                                return Wrap(
                                  children: _menuList[section].asMap().keys.map((index) {
                                    return Container(
                                        height: _rowHeight,
                                        width: _itemWidth,
                                        child: widget.builer(context, section*_rowNums*2 + index),
                                      );
                                  }).toList(),
                                );
                              })?.toList() ??
                              null),
                    )),
              ],
            ),
          );
  }
}
