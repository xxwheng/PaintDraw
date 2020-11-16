import 'package:json_annotation/json_annotation.dart';
import 'ys_item_bean.dart';

part 'home_bean.g.dart';

@JsonSerializable()
class HomeBean {
  @JsonKey(name: "banner")
  List<HomeBannerBean> banner;

  @JsonKey(name: "menu")
  List<HomeMenuBean> menuList;

  @JsonKey(name: "yuesao_top")
  List<HomeTopYuesaoBean> yuesaoTopList;

  HomeBean(this.banner, this.menuList, this.yuesaoTopList);

  factory HomeBean.fromJson(Map<String, dynamic> json) => _$HomeBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBeanToJson(this);
}

@JsonSerializable()
class HomeAdBean {
  @JsonKey(name: "citycode")
  var citycode;

  @JsonKey(name: "desp")
  var desp;

  @JsonKey(name: "id")
  var id;

  @JsonKey(name: "link")
  var link;

  @JsonKey(name: "position")
  var position;

  @JsonKey(name: "status")
  var status;

  @JsonKey(name: "thumb")
  var thumb;

  @JsonKey(name: "title")
  var title;

  HomeAdBean(this.citycode, this.desp, this.id, this.link, this.position, this.status, this.thumb, this.title);

  factory HomeAdBean.fromJson(Map<String, dynamic> json) => _$HomeAdBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeAdBeanToJson(this);
}


@JsonSerializable()
class YsCommentBean {
  @JsonKey(name: "content")
  var content;

  @JsonKey(name: "create_at")
  var create_at;

  @JsonKey(name: "detail_id")
  var detail_id;

  @JsonKey(name: "detail_role")
  var detail_role;

  @JsonKey(name: "headphoto")
  var headphoto;

  @JsonKey(name: "icon")
  var icon;

  @JsonKey(name: "id")
  var id;

  @JsonKey(name: "yuesao_id")
  var yuesao_id;

  @JsonKey(name: "image")
  List<String> image;

  @JsonKey(name: "name")
  var name;

  @JsonKey(name: "nickname")
  var nickname;

  @JsonKey(name: "score")
  var score;

  @JsonKey(name: "user_id")
  var user_id;

  @JsonKey(name: "username")
  var username;

  YsCommentBean(this.content, this.create_at, this.detail_id, this.detail_role, this.headphoto,
      this.icon, this.id, this.yuesao_id, this.image,
      this.name, this.nickname, this.score, this.user_id, this.username);

  factory YsCommentBean.fromJson(Map<String, dynamic> json) => _$YsCommentBeanFromJson(json);

  Map<String, dynamic> toJson() => _$YsCommentBeanToJson(this);
}

@JsonSerializable()
class HomeMenuBean {
  @JsonKey(name: "id")
  var id;

  @JsonKey(name: "link")
  var link;

  @JsonKey(name: "thumb")
  var thumb;

  @JsonKey(name: "title")
  var title;

  HomeMenuBean(this.id, this.link, this.thumb, this.title);

  factory HomeMenuBean.fromJson(Map<String, dynamic> json) => _$HomeMenuBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeMenuBeanToJson(this);
}

@JsonSerializable()
class HomeTopYuesaoBean {
  @JsonKey(name: "id")
  var id;

  @JsonKey(name: "info_yuesao")
  YsItemBean info_yuesao;

  @JsonKey(name: "reason")
  var reason;

  @JsonKey(name: "vedio")
  List<String> vedio;

  @JsonKey(name: "yuesao_id")
  var yuesao_id;

  HomeTopYuesaoBean(this.id, this.info_yuesao, this.reason, this.vedio, this.yuesao_id);

  factory HomeTopYuesaoBean.fromJson(Map<String, dynamic> json) => _$HomeTopYuesaoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeTopYuesaoBeanToJson(this);
}


@JsonSerializable()
class HomeBannerBean {
  @JsonKey(name: "category")
  var category;

  @JsonKey(name: "citycode")
  var citycode;

  @JsonKey(name: "corp_id")
  var corp_id;

  @JsonKey(name: "create_at")
  var create_at;

  @JsonKey(name: "id")
  var id;

  @JsonKey(name: "image")
  var image;

  @JsonKey(name: "position")
  var position;

  @JsonKey(name: "status")
  var status;

  @JsonKey(name: "title")
  var title;

  @JsonKey(name: "type")
  var type;

  @JsonKey(name: "extend")
  BannerExtendBean extend;

  HomeBannerBean([this.category, this.citycode, this.corp_id,
    this.create_at, this.id, this.image, this.position,
    this.status, this.title, this.type, this.extend
  ]);

  factory HomeBannerBean.fromJson(Map<String, dynamic> json) => _$HomeBannerBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBannerBeanToJson(this);

//  factory HomeBannerBean.fromJson(Map<String, dynamic> json) {
//    return HomeBannerBean(category: json['category'], citycode: json['citycode'],
//        corp_id: json['corp_id'], create_at: json['create_at'], id: json['id'],
//        image: json['image'], position: json['position'], status: json['status'],
//        title: json['title'], type: json['type'], extend: json['extend']);
//  }
}

@JsonSerializable()
class BannerExtendBean {
  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "url")
  String url;

  BannerExtendBean([this.title, this.url]);

  factory BannerExtendBean.fromJson(Map<String, dynamic> json) => _$BannerExtendBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BannerExtendBeanToJson(this);
}