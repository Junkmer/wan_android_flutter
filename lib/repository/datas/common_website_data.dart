/// id : 6
/// link : ""
/// name : "面试"
/// order : 1
/// visible : 1
/// 常用网站返回数据
class CommonWebsiteListData {
  List<CommonWebsiteData>? websiteList;

  CommonWebsiteListData.fromJson(dynamic json) {
    websiteList = [];
    if (json is List) {
      for (var element in json) {
        websiteList?.add(CommonWebsiteData.fromJson(element));
      }
    }
  }
}

class CommonWebsiteData {
  CommonWebsiteData({
    this.id,
    this.link,
    this.name,
    this.order,
    this.visible,
  });

  CommonWebsiteData.fromJson(dynamic json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  num? id;
  String? link;
  String? name;
  num? order;
  num? visible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['link'] = link;
    map['name'] = name;
    map['order'] = order;
    map['visible'] = visible;
    return map;
  }
}
