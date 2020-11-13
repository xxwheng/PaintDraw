// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_yswork_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigYsWorkBean _$ConfigYsWorkBeanFromJson(Map<String, dynamic> json) {
  return ConfigYsWorkBean(
    (json['level_skiller_yuying'] as List)
        ?.map((e) =>
            e == null ? null : LevelBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['level_yuesao'] as List)
        ?.map((e) =>
            e == null ? null : LevelBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['province_skiller_yuying'] as List)
        ?.map((e) =>
            e == null ? null : ProvinceBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['province_yuesao'] as List)
        ?.map((e) =>
            e == null ? null : ProvinceBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['service_day'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$ConfigYsWorkBeanToJson(ConfigYsWorkBean instance) =>
    <String, dynamic>{
      'level_skiller_yuying': instance.levelYuyingArr,
      'level_yuesao': instance.levelYusaoArr,
      'province_skiller_yuying': instance.provinceYuyingArr,
      'province_yuesao': instance.provinceYuesaoArr,
      'service_day': instance.serviceDayArr,
    };
