import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/model/config_yswork_bean.dart';
import 'package:demo/model/level_bean.dart';
import 'package:demo/model/province_bean.dart';
import 'package:demo/model/year_filter_bean.dart';
import 'package:demo/model/ys_item_bean.dart';
import 'package:demo/model/ys_list_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/ys_filter_picker.dart';
import 'package:demo/slice/ys_wrap_filter.dart';
import 'package:demo/template/yuesao/cell_yuesao.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/utils/single_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

/* 月嫂列表页 */
class YuesaoListPage extends StatefulWidget {
  @override
  _YuesaoListPageState createState() => _YuesaoListPageState();
}

class _YuesaoListPageState extends State<YuesaoListPage>
    with PageDataSource<YsItemBean>, SingleTickerProviderStateMixin {
  int navIndex = 0;
  List<Map<String, String>> navArray = [
    {"title": "综合", "desc": "1"},
    {"title": "价格", "desc": "1"},
    {"title": "评价", "desc": "1"},
    {"title": "筛选", "desc": "1"},
  ];

  bool showFilter = false;

  Animation<double> animation;

  AnimationController controller;

  ConfigYsWorkBean configBean = ConfigYsWorkBean();


  /// 筛选省份
  ProvinceBean filterProvince;
  /// 服务天数
  String dayBuy = "26";

  /// 年龄数组
  List<YsFilterYearBean> yearFilterArray;
  /// 筛选年龄
  YsFilterYearBean yearBean;

  /// 筛选等级
  LevelBean levelBean;

  /// 筛选日期
  String predictDay;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initData();

    controller =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
        reverseCurve: Curves.linear);
    animation.addListener(() {
      setState(() {});
    });
    animation = Tween(
            begin: -double.parse(AdaptUI.screenHeight.toString()),
            end: double.parse(AdaptUI.rpx(120).toString()))
        .animate(controller);
    loadPageData();
    loadYuesaoConfigWork();
  }

  void initData() {
    filterProvince = ProvinceBean("", "");
    var titleArr = ["不限", "30岁以下", "30~40岁", "40岁以上"];
    setState(() {
      yearFilterArray = titleArr.asMap().keys.map((e) => YsFilterYearBean(e, titleArr[e])).toList();
    });
    yearBean = yearFilterArray[0];
    print(yearFilterArray.length);
  }

  void showPickerWidget() {
    print("显示picker");

  }

  /* 导航按钮点击 */
  void navItemDidTap(int index) {
    if (this.navIndex == index) {
      if (index < this.navArray.length - 1 && index > 0) {
        this.navArray[index]["desc"] =
            this.navArray[index]["desc"] == "1" ? "0" : "1";
      }
    }
    setState(() {
      this.navIndex = index;
    });

    if (this.navIndex < this.navArray.length - 1) {
      this.onRefresh();
      this.filterTapDimiss();
    } else {
      this.filterShow();
    }
  }

  // 筛选窗弹出
  void filterShow() {
    setState(() {
      this.showFilter = true;
    });
    this.controller.forward();
  }

  // 筛选确认
  void filterOkDidTap() {
    // 处理筛选参数
    this.onRefresh();
    this.filterTapDimiss();
  }

  // 筛选窗隐藏
  void filterTapDimiss() {
    setState(() {
      this.showFilter = false;
    });
    this.controller.reverse();
  }

  @override
  void loadPageData() async {
    // TODO: implement _loadPageData
    super.loadPageData();

    var timestamp = "";
    if (null != predictDay && predictDay.isNotEmpty) {
      var time = DateTime.parse(predictDay);
      timestamp = (time.millisecondsSinceEpoch/1000).toInt().toString();
    }

    XXNetwork.shared.post(params: {
      "list_order": "${this.navIndex < 3 ? this.navIndex+1 : 1}",
      "force_desc": "${this.navArray[this.navIndex]["desc"]}",
      "methodName": "YuesaoIndex",
      "day_buy": dayBuy,
      "size": "$size",
      "page": "$page",
      "level": "${levelBean?.levelId ?? 0}",
      "year": "${yearBean?.year ?? 0}",
      "region": "${filterProvince?.code ?? 0}",
      "predict_day": timestamp
    }).then((res) {
      var ysList = YsListBean.fromJson(res);
      var page = int.parse(ysList.page.toString());
      var total = int.parse(ysList.total.toString());
      addList(ysList.data, page, total, setState);
    }).catchError((err) {
      this.endRefreshing(status: false);
    }).whenComplete(() {});
  }

  /* 筛选配置 */
  void loadYuesaoConfigWork() async {
    XXNetwork.shared.post(params: {
      "methodName": "ConfigYuesaoOnwork",
    }).then((value) {
      ConfigYsWorkBean configBean = ConfigYsWorkBean.fromJson(value);
      setState(() {
        this.dayBuy = configBean.serviceDayArr?.first.toString() ?? "26";
        this.configBean = configBean;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: AdaptUI.rpx(120),
            left: 0,
            right: 0,
            bottom: 0,
            child: PageRefreshWidget(
              pageDataSource: this,
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.only(left: AdaptUI.rpx(30)),
                    margin: EdgeInsets.only(
                        left: AdaptUI.rpx(30),
                        top: AdaptUI.rpx(20),
                        right: AdaptUI.rpx(30),
                        bottom: AdaptUI.rpx(0)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AdaptUI.rpx(10))),
                    child: GestureDetector(
                      child: CellYuesao(ysItemBean: list[index]),
                      onTapUp: (TapUpDetails detail) {},
                    ));
              },
            )),
        Positioned(
            top: AdaptUI.rpx(120),
            left: 0,
            right: 0,
            bottom: showFilter ? 0 : AdaptUI.screenHeight,
            child: Opacity(
              opacity: showFilter ? 0.5 : 0,
              child: Container(
                color: Colors.black,
              ),
            )),

        Positioned(
          top: animation.value,
          left: 0,
          right: 0,
          height: AdaptUI.screenHeight,
          child: Container(
            child: Column(
              children: [
                YsFilterPickerRowWidget(
                  height: AdaptUI.rpx(90),
                  title: "预约时间",
                  hintText: "请选择预约时间",
                  content: this.predictDay,
                  tapAction: (tap) => DatePicker.showDatePicker(this.context, onConfirm: (date) {
                    var dateStr = date.toString().split(" ").first;
                    setState(() {
                      this.predictDay = dateStr;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.zh),
                ),
                YsFilterPickerRowWidget(
                  height: AdaptUI.rpx(100),
                  title: "服务天数",
                  hintText: "请选择服务天数",
                  content: this.dayBuy,
                  tapAction: (tap) => SinglePicker(context: this.context, list: configBean.serviceDayArr.map((e) => e.toString()).toList(), itemChanged: (index) {
                    setState(() {
                      this.dayBuy = configBean.serviceDayArr[index].toString();
                    });
                  }).show(),
                ),
                Container(
                  padding: EdgeInsets.only(left: AdaptUI.rpx(30), top: AdaptUI.rpx(20), bottom: AdaptUI.rpx(20)),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: UIColor.hexEEE, width: 0.5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("等级"),
                      YsWrapFilterWidget(
                        list: this.configBean?.levelYusaoArr?.map((e) => e.title)?.toList(),
                        iwidth: AdaptUI.rpx(158),
                        iheight: AdaptUI.rpx(70),
                        margin: EdgeInsets.only(top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
                        textColor: UIColor.mainColor,
                        itemChanged: (index) {
                          this.levelBean = this.configBean.levelYusaoArr[index];
                        },
                        decoration: (currentIndex, selectedIndex) {
                          return BoxDecoration(
                              color: currentIndex == selectedIndex ? UIColor.mainColor : Colors.white,
                              border: Border.all(width: 1, color: UIColor.mainColor)
                          );
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: AdaptUI.rpx(30), top: AdaptUI.rpx(20), bottom: AdaptUI.rpx(20)),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: UIColor.hexEEE, width: 0.5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("年龄"),
                      YsWrapFilterWidget(list: this.yearFilterArray?.map((e) => e.title)?.toList(),
                        iwidth: AdaptUI.rpx(158),
                        iheight: AdaptUI.rpx(70),
                        margin: EdgeInsets.only(top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
                        textColor: UIColor.mainColor,
                        itemChanged: (index) {
                          this.yearBean = this.yearFilterArray[index];
                        },
                        decoration: (currentIndex, selectedIndex) {
                          return BoxDecoration(
                              color: currentIndex == selectedIndex ? UIColor.mainColor : Colors.white,
                              border: Border.all(width: 1, color:  UIColor.mainColor)
                          );
                        },
                      )
                    ],
                  ),
                ),
                YsFilterPickerRowWidget(
                  height: AdaptUI.rpx(100),
                  title: "籍贯",
                  hintText: "请选择籍贯",
                  content: this.filterProvince?.cityName ?? "",
                  tapAction: (tap) =>
                    SinglePicker(context: this.context, list: configBean.provinceYuesaoArr.map((e) => e.cityName).toList(), itemChanged: (index) {
                      print(configBean.provinceYuesaoArr[index].code);
                      setState(() {
                        this.filterProvince = configBean.provinceYuesaoArr[index];
                      });
                    }).show()
                  ,
                ),
                Container(
                  height: AdaptUI.rpx(150),
                  padding: EdgeInsets.only(left: AdaptUI.rpx(120), right: AdaptUI.rpx(120)),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(width: AdaptUI.rpx(220), height: AdaptUI.rpx(80),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Center(child: Text("取消")),
                        ),
                        onTapUp: (tap) => this.filterTapDimiss(),
                      ),
                      GestureDetector(
                        child: Container(width: AdaptUI.rpx(220), height: AdaptUI.rpx(80),
                          decoration: BoxDecoration(
                              color: UIColor.mainColor,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Center(child: Text("确定", style: TextStyle(color: Colors.white),)),),
                        onTapUp: (tap) => this.filterOkDidTap(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // 顶部筛选导航
        Positioned(
            height: AdaptUI.rpx(120),
            child: Container(
              color: Colors.white,
              height: AdaptUI.rpx(120),
              width: AdaptUI.screenWidth,
              child: Row(
                  children: navArray.asMap().keys.map((index) {
                return Expanded(
                  child: GestureDetector(
                    child: Container(
                        height: AdaptUI.rpx(120),
                        child: Center(
                          child: Text(
                            navArray[index]["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: navIndex == index
                                    ? UIColor.mainColor
                                    : UIColor.hex333),
                          ),
                        )),
                    onTapUp: (tap) => this.navItemDidTap(index),
                  ),
                );
              }).toList()),
            )),
      ],
    ));
  }
}
