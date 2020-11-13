
import 'package:json_annotation/json_annotation.dart';

part 'level_bean.g.dart';

@JsonSerializable()
class LevelBean {

  @JsonKey(name: "level_id")
  int levelId;

  @JsonKey(name: "title")
  String title;

  LevelBean(this.levelId, this.title);

  factory LevelBean.fromJson(Map<String, dynamic> json) => _$LevelBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LevelBeanToJson(this);
}