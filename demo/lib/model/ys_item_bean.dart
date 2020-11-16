
import 'package:json_annotation/json_annotation.dart';

part 'ys_item_bean.g.dart';

/* 月嫂列表 单项  */

@JsonSerializable()
class YsItemBean extends Object {

  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "level")
  String level;

  @JsonKey(name: "is_credit")
  var isCredit;

  @JsonKey(name: "citycode")
  String cityCode;

  @JsonKey(name: "province")
  String province;

  @JsonKey(name: "score_comment")
  var scoreComment;

  @JsonKey(name: "comment_score")
  var commentScore;

  @JsonKey(name: "certificate")
  String certificate;

  @JsonKey(name: "birthday")
  String birthday;

  @JsonKey(name: "province_name")
  String provinceName;

  @JsonKey(name: "nickname")
  String nickname;

  @JsonKey(name: "headphoto")
  String headPhoto;

  @JsonKey(name: "price")
  int price;

  @JsonKey(name: "desc")
  String desc;

  @JsonKey(name: "service")
  int service;

  @JsonKey(name: "experience")
  var experience;

  @JsonKey(name: "market_price")
  var market_price;

  YsItemBean(this.id,this.level,this.isCredit,this.cityCode,this.province,
      this.scoreComment,this.commentScore,this.certificate,this.birthday,
      this.provinceName,this.nickname,this.headPhoto,this.desc,this.price,this.service);

  factory YsItemBean.fromJson(Map<String, dynamic> json) => _$YsItemBeanFromJson(json);

  Map<String, dynamic> toJson() => _$YsItemBeanToJson(this);
}