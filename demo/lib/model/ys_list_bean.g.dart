// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ys_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YsListBean _$YsListBeanFromJson(Map<String, dynamic> json) {
  return YsListBean(
    json['page'],
    json['size'],
    json['total'],
    json['count'],
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : YsItemBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$YsListBeanToJson(YsListBean instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'total': instance.total,
      'count': instance.count,
      'data': instance.data,
    };
