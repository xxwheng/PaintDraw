import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/model/article_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/article_widget.dart';
import 'package:flutter/material.dart';

/// 文章 分页
class ArticleTabBarView extends StatefulWidget {
  final String categoryId;

  ArticleTabBarView({Key key, this.categoryId}) : super(key: key);

  @override
  _ArticleTabBarViewState createState() => _ArticleTabBarViewState();
}

class _ArticleTabBarViewState extends State<ArticleTabBarView>
    with PageDataSource<ArticleBean> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh();
  }

  @override
  void loadPageData() {
    // TODO: implement loadPageData
    super.loadPageData();
    XXNetwork.shared.post(params: {
      "methodName": "ArticleList",
      "category_id": widget.categoryId,
      "size": "$size",
      "page": "$page",
    }).then((res) {
      var articleList = (res['data'] as List)
          ?.map((e) => e == null ? null : ArticleBean.fromJson(e))
          ?.toList();
      print(res);
      var page = int.parse(res['page'].toString());
      var total = int.parse(res['total'].toString());
      addList(articleList, page, total, setState);
    }).catchError((err) {
      this.endRefreshing(status: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AdaptUI.rpx(10), bottom: AdaptUI.rpx(40)),
      color: Colors.white,
      child: PageRefreshWidget(
        pageDataSource: this,
        itemBuilder: (context, index) {
          ArticleBean item = list[index];
          return ArticleWidget(
            imageUrl: item.image,
            title: item.title,
            desc: item.desc,
          );
        },
      ),
    );
  }
}
