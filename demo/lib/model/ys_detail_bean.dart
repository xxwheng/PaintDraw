import 'package:demo/model/xx_id_title.dart';

/* 月嫂详情 */
class YsDetailBean {

  var corpInfo;

  String desp;

  int isCollect;

  YsDetailCreditBean credit;

  YsDetailProfileBean profile;
  
  YsDetailBean(this.corpInfo, this.desp, this.isCollect, this.credit, this.profile);
  
  factory YsDetailBean.fromJson(Map<String, dynamic> json) {
    return YsDetailBean(json['corp_info'], json['desp'].toString(), json['is_collect'] as int, 
        YsDetailCreditBean.fromJson(json['credit']),
        YsDetailProfileBean.fromJson(json['profile'])
    );
  }
}


class YsDetailCreditBean {
  List certList;
  String collectionCount;
  String duration;
  String experience;
  String satisfaction;
  String services;
  List<String> charts;
  List<XXIdTitleBean> certificate;


  YsDetailCreditBean(this.certList, this.collectionCount, this.duration, this.experience,
      this.satisfaction, this.services, this.charts, this.certificate);

  factory YsDetailCreditBean.fromJson(Map<String, dynamic> json) {
    return YsDetailCreditBean(
        (json['cert_list'] as List), json['collection_count'].toString(),
        json['duration'].toString(), json['experience'].toString(),
        json['satisfaction'].toString(), json['services'].toString(),
        (json['charts'] as List)?.map((e) => e==null ? null : e.toString())?.toList(),
        (json['certificate'] as List)?.map((e) => e==null ? null : XXIdTitleBean.fromJson(e))?.toList()
    );
  }
}


class YsDetailProfileBean {
  String id;
  int age;
  int birthday;
  int commentScore;
  String credit;
  String level;
  String service;
  String cityCode;
  String cityName;
  String nickname;
  String price;
  String priceMarket;
  String province;
  String provinceText;
  String headPhoto;
  String image;
  String introduce;
  List<String> label;

  YsDetailProfileBean(
      this.id, this.age, this.birthday, this.commentScore,
      this.credit, this.level, this.service, this.cityCode,
      this.cityName, this.nickname, this.price, this.priceMarket,
      this.province, this.provinceText, this.headPhoto, this.image,
      this.introduce, this.label);

  factory YsDetailProfileBean.fromJson(Map<String, dynamic> json) {
    return YsDetailProfileBean(
        json['id'].toString(), json['age'] as int, json['birthday'] as int, json['comment_score'] as int,
        json['credit'].toString(), json['level'].toString(), json['service'].toString(), json['citycode'].toString(),
        json['cityname'].toString(), json['nickname'].toString(), json['price'].toString(), json['price_market'].toString(),
        json['province'].toString(), json['province_text'].toString(), json['headphoto'].toString(), json['image'].toString(),
        json['introduce'].toString(), (json['label'] as List)?.map((e) => e == null ? null : e.toString())?.toList());
  }
}