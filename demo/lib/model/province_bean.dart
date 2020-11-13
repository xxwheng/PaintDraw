
import 'package:json_annotation/json_annotation.dart';

part 'province_bean.g.dart';

@JsonSerializable()
class ProvinceBean {

  @JsonKey(name: "code")
  String code;

  @JsonKey(name: "city_name")
  String cityName;

  ProvinceBean(this.code, this.cityName);

  factory ProvinceBean.fromJson(Map<String, dynamic> json) => _$ProvinceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceBeanToJson(this);
}