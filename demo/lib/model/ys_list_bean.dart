
import 'package:demo/model/ys_item_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ys_list_bean.g.dart';

/* 月嫂列表 */

@JsonSerializable()
class YsListBean extends Object {

  @JsonKey(name: "page")
  var page;

  @JsonKey(name: "size")
  var size;

  @JsonKey(name: "total")
  var total;

  @JsonKey(name: "count")
  var count;

  @JsonKey(name: "data")
  List<YsItemBean> data;

  YsListBean(this.page, this.size, this.total, this.count, this.data);

  factory YsListBean.fromJson(Map<String, dynamic> json) => _$YsListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$YsListBeanToJson(this);
}