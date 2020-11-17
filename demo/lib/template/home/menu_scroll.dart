import 'dart:ui';
import 'package:flutter/material.dart';

class MenuScrollWidget extends StatefulWidget {
  final List<String> menuList;

  MenuScrollWidget({Key key, this.menuList}) : super(key: key);

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
    setState(() {
      this._marginTop = top;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      color: Colors.red,
                      height: this._sectionHeight,
                      child: PageView(
                          controller: _controller,
                          children: _menuList?.map((list) {
                                return Wrap(
                                  children: list.asMap().keys.map((index) {
                                    return GestureDetector(
                                      onTapUp: (tap) {},
                                      child: Container(
                                        color: Colors.primaries[index],
                                        height: _rowHeight,
                                        width: _itemWidth,
                                        child: Center(
                                          child: Text("$index"),
                                        ),
                                      ),
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
