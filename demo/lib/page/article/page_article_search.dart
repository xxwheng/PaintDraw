import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/model/article_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/article_widget.dart';
import 'package:flutter/material.dart';

class PageArticleSearch extends StatefulWidget {
  @override
  _PageArticleSearchState createState() => _PageArticleSearchState();
}

class _PageArticleSearchState extends State<PageArticleSearch> with PageDataSource<ArticleBean> {
  TextEditingController _controller;

  /// 显示清空按钮
  bool showClear = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        showClear = _controller.text.length > 0;
        setState(() {});
      });
    onRefresh();
  }

  @override
  void loadPageData() {
    // TODO: implement loadPageData
    super.loadPageData();
    XXNetwork.shared.post(params: {
      "methodName": "ArticleSearch",
      "keyword": _controller?.text ?? "",
      "size": "$size",
      "page": "$page",
    }).then((res) {

      var articleList = (res['data'] as List)
          ?.map((e) => e == null ? null : ArticleBean.fromJson(e))
          ?.toList();

      var page = int.parse(res['page'].toString());
      var total = 0;
      if (res['total'].toString().isNotEmpty) {
        total = int.parse(res['total'].toString());
      }

      addList(articleList, page, total, setState);
    }).catchError((err) {
      print(err);
      this.endRefreshing(status: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 36,
          width: AdaptUI.rpx(500),
          padding: EdgeInsets.only(
            left: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          child: TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) => this.onRefresh(),
            decoration: InputDecoration(
              hintText: "请输入搜索内容",
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.all(0),
              suffixIcon: !showClear
                  ? Offstage()
                  : GestureDetector(
                      onTap: () => _controller.text = '',
                      child: Container(
                        margin: EdgeInsets.fromLTRB(14, 8, 14, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0x99999999),
                        ),
                        child: Icon(
                          Icons.clear,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: this.onRefresh,
            child: Container(
              padding: EdgeInsets.only(right: AdaptUI.rpx(40)),
              child: Center(
                child: Text(
                  "搜索",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
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
      ),
    );
  }
}
