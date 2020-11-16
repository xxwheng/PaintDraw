// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ys_item_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YsItemBean _$YsItemBeanFromJson(Map<String, dynamic> json) {
  return YsItemBean(
    json['id'] as int,
    json['level'] as String,
    json['is_credit'],
    json['citycode'] as String,
    json['province'] as String,
    json['score_comment'],
    json['comment_score'],
    json['certificate'] as String,
    json['birthday'] as String,
    json['province_name'] as String,
    json['nickname'] as String,
    json['headphoto'] as String,
    json['desc'] as String,
    json['price'] as int,
    json['service'] as int,
  )
    ..experience = json['experience']
    ..market_price = json['market_price'];
}

Map<String, dynamic> _$YsItemBeanToJson(YsItemBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'is_credit': instance.isCredit,
      'citycode': instance.cityCode,
      'province': instance.province,
      'score_comment': instance.scoreComment,
      'comment_score': instance.commentScore,
      'certificate': instance.certificate,
      'birthday': instance.birthday,
      'province_name': instance.provinceName,
      'nickname': instance.nickname,
      'headphoto': instance.headPhoto,
      'price': instance.price,
      'desc': instance.desc,
      'service': instance.service,
      'experience': instance.experience,
      'market_price': instance.market_price,
    };
