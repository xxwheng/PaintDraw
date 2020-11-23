/// 我的-个人信息
class UserInfoBean {
  String headPhoto;
  String id;
  String nickName;
  String predictDay;
  String role;

  UserInfoBean(this.headPhoto, this.id, this.nickName, this.predictDay, this.role);

  factory UserInfoBean.fromJson(Map<String,dynamic> json) {
    return UserInfoBean(json["headphoto"] as String, json["id"] as String, json["nickname"] as String, json["predict_day"] as String, json["role"] as String);
  }
}