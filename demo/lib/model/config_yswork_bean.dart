
import 'package:demo/model/level_bean.dart';
import 'package:demo/model/province_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_yswork_bean.g.dart';

@JsonSerializable()
class ConfigYsWorkBean {

  @JsonKey(name: "level_skiller_yuying")
  List<LevelBean> levelYuyingArr = [];

  @JsonKey(name: "level_yuesao")
  List<LevelBean> levelYusaoArr = [];

  @JsonKey(name: "province_skiller_yuying")
  List<ProvinceBean> provinceYuyingArr = [];

  @JsonKey(name: "province_yuesao")
  List<ProvinceBean> provinceYuesaoArr = [];

  @JsonKey(name: "service_day")
  List<int> serviceDayArr = [];

  ConfigYsWorkBean([this.levelYuyingArr, this.levelYusaoArr, this.provinceYuyingArr, this.provinceYuesaoArr, this.serviceDayArr]);

  factory ConfigYsWorkBean.fromJson(Map<String, dynamic> json) => _$ConfigYsWorkBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigYsWorkBeanToJson(this);
}