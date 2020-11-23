
/// 我的关注
class UserCollectBean {
  String id;
  UserCollectYsInfoBean info;
  String type;
  String referId;
  String ownerId;

  UserCollectBean(this.id, this.info, this.type, this.referId, this.ownerId);

  factory UserCollectBean.fromJson(Map<String,dynamic> json) {
    return UserCollectBean(
        json["id"].toString(),
        UserCollectYsInfoBean.fromJson(json["info"]),
        json["type"].toString(),
        json["refer_id"].toString(),
        json["owner_id"].toString());
  }
}

/// 关注-月嫂信息
class UserCollectYsInfoBean {
  String icon;
  int isCredit;
  String level;
  String price;
  String name;
  String service;
  int scoreComment;
  String recommend;

  UserCollectYsInfoBean(this.icon, this.isCredit, this.level, this.price, this.name, this.service, this.scoreComment, this.recommend);

  factory UserCollectYsInfoBean.fromJson(Map<String,dynamic> json) {
    return UserCollectYsInfoBean(
        json['icon'] as String,
        int.parse(json['is_credit'].toString()),
        json['level'].toString(),
        json['price'].toString(),
        json['name'].toString(),
        json['service'].toString(),
        int.parse(json['score_comment'].toString()),
        json['recommend'].toString());
  }
}