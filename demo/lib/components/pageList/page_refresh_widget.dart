import 'package:adaptui/adaptui.dart';
import 'package:demo/components/pageList/page_interface.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/* 列表 刷新 页 */
class PageRefreshWidget<T> extends StatelessWidget {

  PageDataSource<T> pageDataSource;
  IndexedWidgetBuilder itemBuilder;

  PageRefreshWidget({Key key, @required this.pageDataSource, @required this.itemBuilder}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp:pageDataSource.enablePullUp,
      controller: pageDataSource.refreshController,
      onRefresh: pageDataSource.onRefresh,
      onLoading: pageDataSource.onLoadMore,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          switch (mode) {
            case LoadStatus.idle:
              body = Text("上拉加载更多");
              break;
            case LoadStatus.loading:
              body = CupertinoActivityIndicator();
              break;
            case LoadStatus.failed:
              body = Text("加载失败,点击重试");
              break;
            case LoadStatus.canLoading:
              body = Text("松开加载更多");
              break;
            default:
              body = Text("暂无更多数据");
              break;
          }
          return Container(
            height: AdaptUI.rpx(100),
            child: Center(
              child: body,
            ),
          );
        },
      ),
      child: ListView.builder(
        itemCount: pageDataSource.list.length,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
