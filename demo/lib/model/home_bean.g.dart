// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBean _$HomeBeanFromJson(Map<String, dynamic> json) {
  return HomeBean(
    (json['banner'] as List)
        ?.map((e) => e == null
            ? null
            : HomeBannerBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['menu'] as List)
        ?.map((e) =>
            e == null ? null : HomeMenuBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['yuesao_top'] as List)
        ?.map((e) => e == null
            ? null
            : HomeTopYuesaoBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeBeanToJson(HomeBean instance) => <String, dynamic>{
      'banner': instance.banner,
      'menu': instance.menuList,
      'yuesao_top': instance.yuesaoTopList,
    };

HomeAdBean _$HomeAdBeanFromJson(Map<String, dynamic> json) {
  return HomeAdBean(
    json['citycode'],
    json['desp'],
    json['id'],
    json['link'],
    json['position'],
    json['status'],
    json['thumb'],
    json['title'],
  );
}

Map<String, dynamic> _$HomeAdBeanToJson(HomeAdBean instance) =>
    <String, dynamic>{
      'citycode': instance.citycode,
      'desp': instance.desp,
      'id': instance.id,
      'link': instance.link,
      'position': instance.position,
      'status': instance.status,
      'thumb': instance.thumb,
      'title': instance.title,
    };

YsCommentBean _$YsCommentBeanFromJson(Map<String, dynamic> json) {
  return YsCommentBean(
    json['content'],
    json['create_at'],
    json['detail_id'],
    json['detail_role'],
    json['headphoto'],
    json['icon'],
    json['id'],
    json['yuesao_id'],
    (json['image'] as List)?.map((e) => e as String)?.toList(),
    json['name'],
    json['nickname'],
    json['score'],
    json['user_id'],
    json['username'],
  );
}

Map<String, dynamic> _$YsCommentBeanToJson(YsCommentBean instance) =>
    <String, dynamic>{
      'content': instance.content,
      'create_at': instance.create_at,
      'detail_id': instance.detail_id,
      'detail_role': instance.detail_role,
      'headphoto': instance.headphoto,
      'icon': instance.icon,
      'id': instance.id,
      'yuesao_id': instance.yuesao_id,
      'image': instance.image,
      'name': instance.name,
      'nickname': instance.nickname,
      'score': instance.score,
      'user_id': instance.user_id,
      'username': instance.username,
    };

HomeMenuBean _$HomeMenuBeanFromJson(Map<String, dynamic> json) {
  var thumb = json['thumb'].toString();
  if (!thumb.contains("http")) {
    thumb = HttpConfig.webUrl + thumb;
  }
  return HomeMenuBean(
    json['id'],
    json['link'],
    thumb,
    json['title'],
  );
}

Map<String, dynamic> _$HomeMenuBeanToJson(HomeMenuBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'thumb': instance.thumb,
      'title': instance.title,
    };

HomeTopYuesaoBean _$HomeTopYuesaoBeanFromJson(Map<String, dynamic> json) {
  return HomeTopYuesaoBean(
    json['id'],
    json['info_yuesao'] == null
        ? null
        : YsItemBean.fromJson(json['info_yuesao'] as Map<String, dynamic>),
    json['reason'],
    (json['vedio'] as List)?.map((e) => e as String)?.toList(),
    json['yuesao_id'],
  );
}

Map<String, dynamic> _$HomeTopYuesaoBeanToJson(HomeTopYuesaoBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'info_yuesao': instance.info_yuesao,
      'reason': instance.reason,
      'vedio': instance.vedio,
      'yuesao_id': instance.yuesao_id,
    };

HomeBannerBean _$HomeBannerBeanFromJson(Map<String, dynamic> json) {
  return HomeBannerBean(
    json['category'],
    json['citycode'],
    json['corp_id'],
    json['create_at'],
    json['id'],
    json['image'],
    json['position'],
    json['status'],
    json['title'],
    json['type'],
    json['extend'] == null
        ? null
        : BannerExtendBean.fromJson(json['extend'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HomeBannerBeanToJson(HomeBannerBean instance) =>
    <String, dynamic>{
      'category': instance.category,
      'citycode': instance.citycode,
      'corp_id': instance.corp_id,
      'create_at': instance.create_at,
      'id': instance.id,
      'image': instance.image,
      'position': instance.position,
      'status': instance.status,
      'title': instance.title,
      'type': instance.type,
      'extend': instance.extend,
    };

BannerExtendBean _$BannerExtendBeanFromJson(Map<String, dynamic> json) {
  return BannerExtendBean(
    json['title'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$BannerExtendBeanToJson(BannerExtendBean instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
    };
