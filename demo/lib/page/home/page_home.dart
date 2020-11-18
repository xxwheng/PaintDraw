import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/model/home_bean.dart';
import 'package:demo/model/ys_item_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/home_learn_more.dart';
import 'package:demo/slice/home_ys_top.dart';
import 'package:demo/template/home/menu_scroll.dart';
import 'package:demo/utils/ys_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../common/color.dart';
import '../../model/home_bean.dart';
import '../../model/home_bean.dart';
import '../../network/dio/http_config.dart';
import '../../template/home/menu_scroll.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  HomeBean homeData;

  /// 处理flutter_swiper组件 loop为true时 初始化滑动很多次问题
  bool _bannerLoop = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHomeData();
  }

  /// banner点击
  void bannerItemDidTap(index) {
    var item = homeData.banner[index];
  }

  /// 菜单按钮点击
  void menuItemDidTap(HomeMenuBean bean) {
    switch (bean.id.toString()) {
      case "1":
        break;
      default:
        break;
    }
  }

  /// 加载首页数据
  void loadHomeData() async {
    XXNetwork.shared
        .post(params: {
          "methodName": "YuesaoHome",
        })
        .then((res) {

          var list = (res['comment'] as List)
              ?.map((e) =>
          e == null ? null : CommentBean.fromJson(e as Map<String, dynamic>))
              ?.toList();
          print(list.first.content);

          var homeData = HomeBean.fromJson(res);
          homeData.adArr = [];
          if (homeData.homeAdLeftBean != null) {
            homeData.adArr.add(homeData.homeAdLeftBean);
          }
          if (homeData.homeAdRightBean != null) {
            homeData.adArr.add(homeData.homeAdRightBean);
          }
          // 菜单图标没有域名
          homeData.menuList.forEach((e) {
            if (e.thumb.isNotEmpty && !e.thumb.contains("http")) {
              e.thumb = HttpConfig.webUrl + e.thumb;
            }
          });
          // 月嫂之星头像没有域名
          homeData.yuesaoTopList.forEach((e) {
            if (e.info_yuesao.headPhoto.isNotEmpty && !e.info_yuesao.headPhoto.contains("http")) {
              e.info_yuesao.headPhoto = HttpConfig.webUrl + e.info_yuesao.headPhoto;
            }
          });
          print("更新数据");
          setState(() {
            this.homeData = homeData;
            this._bannerLoop = true;
          });
        })
        .catchError((err) {})
        .whenComplete(() {});
  }

  /// 菜单导航按钮
  Widget menuItemWidgetBuiler(context, index) {
    HomeMenuBean item = homeData.menuList[index];
    return GestureDetector(
        onTapUp: (tap) {
          menuItemDidTap(item);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AdaptUI.rpx(80),
              height: AdaptUI.rpx(80),
              child: CachedNetworkImage(
                imageUrl: item.thumb,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: AdaptUI.rpx(10)),
              child: Center(
                child: Text(item.title),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIColor.pageColor,
        body: ListView(
          children: [
            Container(
              height: AdaptUI.rpx(280),
              child: Swiper(
                loop: _bannerLoop,
                autoplay: true,
                itemCount: homeData == null ? 0 : homeData.banner.length,
                pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        activeColor: UIColor.mainColor)),
                itemBuilder: (context, index) {
                  var item = homeData?.banner[index];
                  return CachedNetworkImage(
                      imageUrl: item.image.toString(), fit: BoxFit.cover);
                },
                onTap: bannerItemDidTap,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
              padding: EdgeInsets.only(
                  top: AdaptUI.rpx(30), bottom: AdaptUI.rpx(20)),
              color: Colors.white,
              child: MenuScrollWidget(
                menuList: homeData?.menuList
                        ?.map((e) => e.title.toString())
                        ?.toList() ??
                    [],
                builer: menuItemWidgetBuiler,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
              child: Row(
                children: homeData?.adArr?.asMap()?.keys?.map((index) {
                      return Container(
                        decoration: BoxDecoration(
                            border: index == 0
                                ? Border(
                                    right: BorderSide(color: UIColor.hexEEE))
                                : null),
                        height: AdaptUI.rpx(200),
                        width: AdaptUI.screenWidth / 2,
                        child: CachedNetworkImage(
                          imageUrl: homeData.adArr[index].thumb.toString(),
                          fit: BoxFit.cover,
                        ),
                      );
                    })?.toList() ??
                    [],
              ),
            ),
            homeData?.yuesaoTopList == null || homeData.yuesaoTopList.length == 0 ? Container() : Container(
                margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                color: Colors.white,
                child: Column(
                  children: [
                    HomeLearnMoreHeaderWidget(
                      title: "月嫂之星",
                      margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                    ),
                    Container(
                      height: AdaptUI.rpx(470),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: homeData?.yuesaoTopList?.length ?? 0,
                        itemBuilder: (context, index) {
                          HomeTopYuesaoBean item =
                              homeData.yuesaoTopList[index];
                          return HomeYuesaoTopWidget(
                            margin: EdgeInsets.only(
                                left: index == 0 ? AdaptUI.rpx(30) : 0,
                                top: AdaptUI.rpx(20), bottom: AdaptUI.rpx(40), right: AdaptUI.rpx(20)),
                            imageUrl: item.info_yuesao.headPhoto,
                            name: item.info_yuesao.provinceName + "·" + item.info_yuesao.nickname,
                            levelStr: YsLevel.getYuesaoLevel(item.info_yuesao.level),
                          );
                        },
                      ),
                    )
                  ],
                )),
            homeData?.commentList == null || homeData.commentList.length == 0 ? Container() : Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
              color: Colors.white,
              child: Column(
                children: [
                  HomeLearnMoreHeaderWidget(
                    title: "美妈点评",
                    margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(AdaptUI.rpx(30), AdaptUI.rpx(20), AdaptUI.rpx(30), AdaptUI.rpx(30)),
                    height: AdaptUI.rpx(500),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: UIColor.hexEEE, width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Color.fromRGBO(221, 221, 221, 0.4))
                      ],
                    ),
                    child: Swiper(
                      loop: _bannerLoop,
                      autoplay: true,
                      itemCount: homeData?.commentList?.length ?? 0,
                      pagination: SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              size: 6,
                              activeSize: 6,
                              activeColor: UIColor.mainColor,
                              color: Color.fromRGBO(0, 0, 0, 0.2)
                          )),
                      itemBuilder: (context, index) {
                        var item = homeData.commentList[index];
                        return Container(
                          child: Column(
                            children: [

                            ],
                          ),
                        );
                      },
                      onTap: bannerItemDidTap,
                    ),
                  )
                ],
              )
            ),
          ],
        ));
  }
}
