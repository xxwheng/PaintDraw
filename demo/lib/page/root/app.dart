
import 'package:demo/page/mine/ys_collect.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'route_handles.dart';

class App {
  static FluroRouter router;

  static void navigationTo(BuildContext context, String path) {
    router.navigateTo(context, path, transition: TransitionType.cupertino);
  }
}

class PageRoutes {
  /* 底层控制器 */
  static String tabBarController = "/";

  /* 文章搜索页 */
  static String searchArticle = "/page/article/page_article_search";

  // 我的关注
  static String myCollect = "/page/mine/ys_collect";

  static void configFluroRoutes(FluroRouter router) {
    router.define(tabBarController, handler: tabBarHandler);
    router.define(searchArticle, handler: searchArticleHandler);
    router.define(myCollect, handler: myCollectPageHandler);
  }
}
