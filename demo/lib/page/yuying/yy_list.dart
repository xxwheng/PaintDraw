import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/model/config_yswork_bean.dart';
import 'package:demo/model/level_bean.dart';
import 'package:demo/model/province_bean.dart';
import 'package:demo/model/year_filter_bean.dart';
import 'package:demo/model/ys_item_bean.dart';
import 'package:demo/model/ys_list_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/slice/ys_filter_picker.dart';
import 'package:demo/slice/ys_wrap_filter.dart';
import 'package:demo/slice/ys_wrap_multi_filter.dart';
import 'package:demo/template/yuesao/cell_yuesao.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/utils/single_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

/* 育婴师列表页 */
class YuyingListPage extends StatefulWidget {
  @override
  _YuyingListPageState createState() => _YuyingListPageState();
}

class _YuyingListPageState extends State<YuyingListPage>
    with PageDataSource<YsItemBean>, SingleTickerProviderStateMixin {
  int navIndex = 0;
  List<Map<String, String>> navArray = [
    {"title": "综合", "desc": "1"},
    {"title": "价格", "desc": "1"},
    {"title": "评价", "desc": "1"},
    {"title": "筛选", "desc": "1"},
  ];

  bool showFilter = false;

  ConfigYsWorkBean configBean = ConfigYsWorkBean();

  /// 年龄数组
  List<YsFilterYearBean> yearFilterArray;

  /// 筛选年龄
  YsFilterYearBean yearBean;

  /// 育婴师分类 筛选
  List<YuyingFilterCareTypeBean> careTypeFilterArray;
  YuyingFilterCareTypeBean careTypeBean;

  /// 筛选省份
  ProvinceBean filterProvince;

  /// 筛选等级
  List<LevelBean> levelBeanList;

  /// 筛选日期
  String predictDay;

  final double filterMaxH = AdaptUI.screenHeight -
      AdaptUI.safeATop -
      AdaptUI.rpx(120) -
      AdaptUI.rpx(50);
  double filterTop;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    filterTop = -filterMaxH;

    initData();

    onRefresh();
    loadYuyingConfigWork();
  }

  void initData() {
    filterProvince = ProvinceBean("", "");
    var careTypeTitleArr = ["不限", "育婴护理师", "育儿护理师", "幼儿护理师"];
    var yearTitleArr = ["不限", "30岁以下", "30~40岁", "40岁以上"];
    yearFilterArray = yearTitleArr
        .asMap()
        .keys
        .map((e) => YsFilterYearBean(e, yearTitleArr[e]))
        .toList();
    yearBean = yearFilterArray[0];

    careTypeFilterArray = careTypeTitleArr
        .asMap()
        .keys
        .map((e) => YuyingFilterCareTypeBean(e, careTypeTitleArr[e]))
        .toList();
    careTypeBean = careTypeFilterArray[0];
    setState(() {});
  }

  /// 菜单栏 icon
  Widget afterIcon(int index) {
    if (index == 0) {
      return Icon(
        Icons.keyboard_arrow_down,
        size: AdaptUI.rpx(28),
        color: navIndex == 0 ? UIColor.mainColor : UIColor.hex666,
      );
    } else if (index < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.keyboard_arrow_up,
            size: AdaptUI.rpx(28),
            color: navIndex == index && navArray[index]['desc'] == '0'
                ? UIColor.mainColor
                : UIColor.hex666,
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: AdaptUI.rpx(28),
            color: navIndex == index && navArray[index]['desc'] == '1'
                ? UIColor.mainColor
                : UIColor.hex666,
          )
        ],
      );
    } else {
      return Icon(Icons.filter_alt_outlined, size: AdaptUI.rpx(28));
    }
  }

  void showPickerWidget() {
    print("显示picker");
  }

  /* 导航按钮点击 */
  void navItemDidTap(int index) {
    print("${this.navIndex}  $index");
    if (this.navIndex == index) {
      if (index < this.navArray.length - 1 && index > 0) {
        this.navArray[index]["desc"] =
            this.navArray[index]["desc"] == "1" ? "0" : "1";
      } else {
        return;
      }
    }

    if (index < this.navArray.length - 1) {
      this.navIndex = index;
      this.onRefresh();
      this.filterTapDimiss();
      setState(() {});
    } else {
      showFilter ? filterTapDimiss() : filterShow();
    }
  }

  

  @override
  void loadPageData() async {
    // TODO: implement _loadPageData
    super.loadPageData();

    var timestamp = "";
    if (null != predictDay && predictDay.isNotEmpty) {
      var time = DateTime.parse(predictDay);
      timestamp = (time.millisecondsSinceEpoch ~/ 1000).toString();
    }

    XXNetwork.shared.post(params: {
      "list_order": "${this.navIndex < 3 ? this.navIndex + 1 : 1}",
      "force_desc": "${this.navArray[this.navIndex]["desc"]}",
      "methodName": "SkillerYuyingIndex",
      "day_buy": 0,
      "care_type": careTypeBean.id,
      "size": "$size",
      "page": "$page",
      "level": "${levelBeanList?.map((e) => e.levelId)?.join(',') ?? 0}",
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
  void loadYuyingConfigWork() async {
    XXNetwork.shared.post(params: {
      "methodName": "ConfigYuesaoOnwork",
    }).then((value) {
      ConfigYsWorkBean configBean = ConfigYsWorkBean.fromJson(value);
      setState(() {
        this.configBean = configBean;
      });
    });
  }

  // 筛选窗弹出
  void filterShow() {
    this.filterTop = AdaptUI.rpx(120);
    setState(() {
      this.showFilter = true;
    });
  }

  // 筛选确认
  void filterOkDidTap() {
    // 处理筛选参数
    this.onRefresh();
    this.filterTapDimiss();
  }

  // 筛选窗隐藏
  void filterTapDimiss() {
    this.filterTop = -filterMaxH;
    setState(() {
      this.showFilter = false;
    });
  }

  /* 预约时间筛选 */
  void filterDatePickerDidTap() {
    DatePicker.showDatePicker(this.context, onConfirm: (date) {
      var dateStr = date.toString().split(" ").first;
      setState(() {
        this.predictDay = dateStr;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.zh);
  }

  /* 等级筛选， 多选的  */
  void filterLevelIndexTap(List<int> indexArr) {
    this.levelBeanList =
        indexArr.map((e) => this.configBean.levelYuyingArr[e]).toList();
  }

  /* 育婴师分类筛选 */
  void filterCareTypeIndexTap(int index) {
    this.careTypeBean = this.careTypeFilterArray[index];
  }

  /* 年龄筛选 */
  void filterYearIndexTap(int index) {
    this.yearBean = this.yearFilterArray[index];
  }
  
  /* 籍贯选择 */
  void filterRegionPickerDidTap() {
    SinglePicker(
        context: this.context,
        list: configBean.provinceYuyingArr
            .map((e) => e.cityName)
            .toList(),
        itemChanged: (index) {
          print(configBean.provinceYuyingArr[index].code);
          setState(() {
            this.filterProvince =
            configBean.provinceYuyingArr[index];
          });
        }).show();
  }
  
  
  /* 点击进入育婴师详情 */
  void ysItemDidTap(YsItemBean item) {
    App.navigationTo(context, PageRoutes.ysDetailPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("找育婴师"),
        elevation: 0,
      ),
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
                  YsItemBean item = list[index];
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
                      child: CellYuesao(
                        type: 2,
                        isCredit: item.isCredit.toString() == '1',
                        headPhoto: item.headPhoto,
                        level: item.level,
                        careType: item.careType,
                        nickName: item.nickname,
                        desc: item.desc,
                        score: "${item.scoreComment}",
                        price: "${item.price}",
                        service: "${item.service}",
                        showCancel: false,
                      ),
                      onTapUp: (TapUpDetails detail) => this.ysItemDidTap(item),
                    ),
                  );
                },
              )),
          showFilter
              ? Positioned(
                  top: AdaptUI.rpx(120),
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Color(0x55000000),
                  ),
                )
              : Container(),
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            top: filterTop,
            left: 0,
            right: 0,
            child: Container(
              child: Column(
                children: [
                  YsFilterPickerRowWidget(
                    height: AdaptUI.rpx(90),
                    title: "预约时间",
                    hintText: "请选择预约时间",
                    content: this.predictDay,
                    tapAction: (tap) => this.filterDatePickerDidTap(),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: AdaptUI.rpx(30),
                        top: AdaptUI.rpx(20),
                        bottom: AdaptUI.rpx(20)),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom:
                                BorderSide(color: UIColor.hexEEE, width: 0.5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("等级"),
                        YsWrapMultiFilterWidget(
                          list: this
                              .configBean
                              ?.levelYuyingArr
                              ?.map((e) => e.title)
                              ?.toList(),
                          iwidth: AdaptUI.rpx(158),
                          iheight: AdaptUI.rpx(70),
                          margin: EdgeInsets.only(
                              top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
                          textColor: UIColor.mainColor,
                          indexChanged: this.filterLevelIndexTap,
                          decorationIndexArr: (currentIndex, indexArr) {
                            return BoxDecoration(
                                color: indexArr.contains(currentIndex)
                                    ? UIColor.mainColor
                                    : Colors.white,
                                border: Border.all(
                                    width: 1, color: UIColor.mainColor));
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: AdaptUI.rpx(30),
                        top: AdaptUI.rpx(20),
                        bottom: AdaptUI.rpx(20)),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom:
                                BorderSide(color: UIColor.hexEEE, width: 0.5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("育婴师分类"),
                        YsWrapFilterWidget(
                          list: this
                              .careTypeFilterArray
                              ?.map((e) => e.title)
                              ?.toList(),
                          iwidth: AdaptUI.rpx(158),
                          iheight: AdaptUI.rpx(70),
                          margin: EdgeInsets.only(
                              top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
                          textColor: UIColor.mainColor,
                          itemChanged: this.filterCareTypeIndexTap,
                          decoration: (currentIndex, selectedIndex) {
                            return BoxDecoration(
                                color: currentIndex == selectedIndex
                                    ? UIColor.mainColor
                                    : Colors.white,
                                border: Border.all(
                                    width: 1, color: UIColor.mainColor));
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: AdaptUI.rpx(30),
                        top: AdaptUI.rpx(20),
                        bottom: AdaptUI.rpx(20)),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom:
                                BorderSide(color: UIColor.hexEEE, width: 0.5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("年龄"),
                        YsWrapFilterWidget(
                          list: this
                              .yearFilterArray
                              ?.map((e) => e.title)
                              ?.toList(),
                          iwidth: AdaptUI.rpx(158),
                          iheight: AdaptUI.rpx(70),
                          margin: EdgeInsets.only(
                              top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
                          textColor: UIColor.mainColor,
                          itemChanged: this.filterYearIndexTap,
                          decoration: (currentIndex, selectedIndex) {
                            return BoxDecoration(
                                color: currentIndex == selectedIndex
                                    ? UIColor.mainColor
                                    : Colors.white,
                                border: Border.all(
                                    width: 1, color: UIColor.mainColor));
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
                    tapAction: (tap) => this.filterRegionPickerDidTap(),
                  ),
                  Container(
                    height: AdaptUI.rpx(150),
                    padding: EdgeInsets.only(
                        left: AdaptUI.rpx(120), right: AdaptUI.rpx(120)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: AdaptUI.rpx(220),
                            height: AdaptUI.rpx(80),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(child: Text("取消")),
                          ),
                          onTapUp: (tap) => this.filterTapDimiss(),
                        ),
                        GestureDetector(
                          child: Container(
                            width: AdaptUI.rpx(220),
                            height: AdaptUI.rpx(80),
                            decoration: BoxDecoration(
                                color: UIColor.mainColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                                child: Text(
                              "确定",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
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
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
              height: AdaptUI.rpx(120),
              width: AdaptUI.screenWidth,
              child: Row(
                  children: navArray.asMap().keys.map((index) {
                return Expanded(
                  child: InkWell(
                    child: Container(
                      height: AdaptUI.rpx(120),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            navArray[index]["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: AdaptUI.rpx(32),
                                color: navIndex == index
                                    ? UIColor.mainColor
                                    : UIColor.hex333),
                          ),
                          afterIcon(index),
                        ],
                      ),
                    ),
                    onTap: () => this.navItemDidTap(index),
                  ),
                );
              }).toList()),
            ),
          ),
        ],
      ),
    );
  }
}
