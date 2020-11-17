import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/model/home_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/template/home/menu_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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

  List<String> _bannerList = [];

  /// 加载首页数据
  void loadHomeData() async {
    XXNetwork.shared.post(params: {
      "methodName": "YuesaoHome",
    }).then((res) {
      var homeData = HomeBean.fromJson(res);
      setState(() {
        this.homeData = homeData;
        this._bannerLoop = true;
        _bannerList = ["1", "1","1","1","1",];
      });
    }).catchError((err) {
    }).whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: AdaptUI.rpx(280),
          child: Swiper(
            loop: _bannerLoop,
            autoplay: true,
            itemCount: homeData == null ? 0 : homeData.banner.length,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(activeColor: UIColor.mainColor)
            ),
            itemBuilder: (context, index) {
              var item = homeData?.banner[index];
              return CachedNetworkImage(imageUrl: item.image.toString(), fit: BoxFit.cover);
            },
            onTap: bannerItemDidTap,
          ),
        ),
        MenuScrollWidget(
          menuList: _bannerList,
        ),
        Container(height: 100, color: Colors.deepPurple,)
      ],
    );
  }
}
