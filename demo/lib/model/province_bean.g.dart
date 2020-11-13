// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceBean _$ProvinceBeanFromJson(Map<String, dynamic> json) {
  return ProvinceBean(
    json['code'] as String,
    json['city_name'] as String,
  );
}

Map<String, dynamic> _$ProvinceBeanToJson(ProvinceBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'city_name': instance.cityName,
    };
