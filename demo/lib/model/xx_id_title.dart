class XXIdTitleBean {
  String id;
  String title;

  XXIdTitleBean(this.id, this.title);

  factory XXIdTitleBean.fromJson(Map<String, dynamic> json) {
    return XXIdTitleBean(json['id'].toString(), json['title'].toString());
  }
}