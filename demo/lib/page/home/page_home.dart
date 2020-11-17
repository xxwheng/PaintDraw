import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/model/home_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/home_learn_more.dart';
import 'package:demo/template/home/menu_scroll.dart';
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
    print(item.title);
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
          var homeData = HomeBean.fromJson(res);
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
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIColor.pageColor,
      body:
    ListView(

      children: [
        Container(
          height: AdaptUI.rpx(280),
          child: Swiper(
            loop: _bannerLoop,
            autoplay: true,
            itemCount: homeData == null ? 0 : homeData.banner.length,
            pagination: SwiperPagination(
                builder:
                    DotSwiperPaginationBuilder(activeColor: UIColor.mainColor)),
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
          padding: EdgeInsets.only(top: AdaptUI.rpx(30), bottom: AdaptUI.rpx(20)),
          color: Colors.white,
          child: MenuScrollWidget(
            menuList:
            homeData?.menuList?.map((e) => e.title.toString())?.toList() ??
                [],
            builer: menuItemWidgetBuiler,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
          color: Colors.white,
          child: HomeLearnMoreHeaderWidget(
            title: "月嫂之星",
            margin: EdgeInsets.only(top: AdaptUI.rpx(20)),

          ),
        ),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
          color: Colors.white,
          child: HomeLearnMoreHeaderWidget(
            title: "美妈点评",
            margin: EdgeInsets.only(top: AdaptUI.rpx(20)),

          ),
        ),
      ],
    )
    ) ;
  }
}
