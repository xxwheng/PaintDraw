import 'package:demo/page/article/page_article_search.dart';
import 'package:demo/page/mine/ys_collect.dart';
import 'package:demo/page/root/tab_bar.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo/page/yuesao/ys_list.dart';

/* 底层控制器页 */
var tabBarHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        TabBarController());

/* 文章-文章搜索页 */
var searchArticleHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        PageArticleSearch());

/* 我的-我的关注*/
var myCollectPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        YsCollectPage());

/* 首页-月嫂列表 */
var ysListPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => YuesaoListPage());