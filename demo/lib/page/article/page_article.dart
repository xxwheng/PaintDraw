import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/main.dart';
import 'package:demo/model/article_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/slice/article_search.dart';
import 'package:demo/template/article/article_tabbarview.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

/// 文章-tab
class PageArticle extends StatefulWidget {
  @override
  _PageArticleState createState() => _PageArticleState();
}

class _PageArticleState extends State<PageArticle>
    with PageDataSource<ArticleBean> {
  List<ArticleCategoryBean> categoryList;

  List<ArticleBean> articleList;

  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 0, vsync: ScrollableState());
    loadCategoryList();
  }

  /// 获取文章分类列表
  void loadCategoryList() async {
    XXNetwork.shared
        .post(params: {"methodName": "ArticleCategoryList"}).then((res) {
      print(res);
      var categoryList = (res["data"] as List)
          ?.map((e) => e == null ? null : ArticleCategoryBean.fromJson(e))
          ?.toList();
      _controller =
          TabController(length: categoryList.length, vsync: ScrollableState());
      setState(() {
        this.categoryList = categoryList;
      });
    });
  }

  /// 获取文章列表
  void loadArticleList() async {
    if (null == categoryList || categoryList.isEmpty) {
      return;
    }
    String categoryId = categoryList[_controller.index].id;
    XXNetwork.shared.post(params: {
      "methodName": "ArticleList",
      "category_id": categoryId
    }).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("家家月嫂"),
          ),
          elevation: 0,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                height: AdaptUI.rpx(100),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
                child: TabBar(
                  controller: _controller,
                  isScrollable: true,
                  indicatorColor: UIColor.mainColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: UIColor.mainColor,
                  labelStyle: TextStyle(
                      fontSize: AdaptUI.rpx(32), fontWeight: FontWeight.bold),
                  unselectedLabelColor: UIColor.hex333,
                  unselectedLabelStyle: TextStyle(
                      fontSize: AdaptUI.rpx(28), fontWeight: FontWeight.normal),
                  tabs: categoryList?.map((e) {
                        return Text(e.title);
                      })?.toList() ??
                      [],
                ),
              ),
              ArticleSearchWidget(
                tap: () {
                  App.navigationTo(context, PageRoutes.searchArticle);
                },
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: categoryList?.map((e) {
                        return ArticleTabBarView(
                          categoryId: e.id,
                        );
                      })?.toList() ??
                      [],
                ),
              )
            ],
          ),
        ));
  }
}
