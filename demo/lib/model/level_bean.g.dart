// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelBean _$LevelBeanFromJson(Map<String, dynamic> json) {
  return LevelBean(
    json['level_id'] as int,
    json['title'] as String,
  );
}

Map<String, dynamic> _$LevelBeanToJson(LevelBean instance) => <String, dynamic>{
      'level_id': instance.levelId,
      'title': instance.title,
    };
