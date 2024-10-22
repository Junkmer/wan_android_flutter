/// curPage : 1
/// datas : [{"author":"郭霖","chapterId":409,"chapterName":"郭霖","courseId":13,"desc":"","envelopePic":"","id":341914,"link":"https://mp.weixin.qq.com/s/gNP92eyl-5n-JEz1pvdX0w","niceDate":"7分钟前","origin":"","originId":29068,"publishTime":1729587935000,"title":"Android 15 正式发布至 AOSP","userId":164293,"visible":0,"zan":0},{"author":"美团技术团队","chapterId":417,"chapterName":"美团技术团队","courseId":13,"desc":"","envelopePic":"","id":341913,"link":"https://mp.weixin.qq.com/s/ocGLvUmAnglZbcKRmK72Yg","niceDate":"7分钟前","origin":"","originId":29047,"publishTime":1729587933000,"title":"大前端：如何突破动态化容器的天花板？","userId":164293,"visible":0,"zan":0},{"author":"","chapterId":502,"chapterName":"自助","courseId":13,"desc":"","envelopePic":"","id":341426,"link":"https://juejin.cn/post/7412919772587851776","niceDate":"2024-10-11 23:15","origin":"","originId":28947,"publishTime":1728659728000,"title":"Java-基础-05-JVM-1-综述","userId":164293,"visible":0,"zan":0},{"author":"鸿洋","chapterId":408,"chapterName":"鸿洋","courseId":13,"desc":"","envelopePic":"","id":341425,"link":"https://mp.weixin.qq.com/s/4BbjVYwo5tv-SzSW9_9f7Q","niceDate":"2024-10-11 23:15","origin":"","originId":28950,"publishTime":1728659727000,"title":"一款高效的HarmonyOS工具包","userId":164293,"visible":0,"zan":0},{"author":"鸿洋","chapterId":408,"chapterName":"鸿洋","courseId":13,"desc":"","envelopePic":"","id":341424,"link":"https://mp.weixin.qq.com/s/e4JOUsBVqihoZXB3UeRL1g","niceDate":"2024-10-11 23:15","origin":"","originId":28929,"publishTime":1728659723000,"title":"Room数据库使用一些坑","userId":164293,"visible":0,"zan":0},{"author":"","chapterId":502,"chapterName":"自助","courseId":13,"desc":"","envelopePic":"","id":341423,"link":"https://juejin.cn/post/7418501982896635958","niceDate":"2024-10-11 23:15","origin":"","originId":28996,"publishTime":1728659713000,"title":"2024 了， Insets 你不会还不懂吧？","userId":164293,"visible":0,"zan":0},{"author":"张鸿洋","chapterId":543,"chapterName":"Android技术周报","courseId":13,"desc":"","envelopePic":"","id":341409,"link":"/blog/show/3695","niceDate":"2024-10-11 23:13","origin":"","originId":28981,"publishTime":1728659592000,"title":"Android 技术周刊 （2024-09-23 ~ 2024-09-30）","userId":164293,"visible":0,"zan":0},{"author":"鸿洋","chapterId":408,"chapterName":"鸿洋","courseId":13,"desc":"","envelopePic":"","id":341407,"link":"https://mp.weixin.qq.com/s/TPwnOtd1xfXRvIV0voWnRQ","niceDate":"2024-10-11 23:04","origin":"","originId":28970,"publishTime":1728659080000,"title":"面试官：你对插件化有什么了解？","userId":164293,"visible":0,"zan":0},{"author":"张鸿洋","chapterId":543,"chapterName":"Android技术周报","courseId":13,"desc":"","envelopePic":"","id":341408,"link":"/blog/show/3693","niceDate":"2024-10-11 23:04","origin":"","originId":28957,"publishTime":1728659080000,"title":"Android 技术周刊 （2024-09-16 ~ 2024-09-23）","userId":164293,"visible":0,"zan":0},{"author":"张鸿洋","chapterId":543,"chapterName":"Android技术周报","courseId":13,"desc":"","envelopePic":"","id":341404,"link":"/blog/show/3699","niceDate":"2024-10-11 22:54","origin":"","originId":28998,"publishTime":1728658498000,"title":"Android 技术周刊 （2024-09-30 ~ 2024-10-08）","userId":164293,"visible":0,"zan":0}]
/// offset : 0
/// over : true
/// pageCount : 1
/// size : 20
/// total : 10

class CollectListData {
  CollectListData({
      this.curPage, 
      this.datas, 
      this.offset, 
      this.over, 
      this.pageCount, 
      this.size, 
      this.total,});

  CollectListData.fromJson(dynamic json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = [];
      json['datas'].forEach((v) {
        datas?.add(CollectItemData.fromJson(v));
      });
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }
  num? curPage;
  List<CollectItemData>? datas;
  num? offset;
  bool? over;
  num? pageCount;
  num? size;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['curPage'] = curPage;
    if (datas != null) {
      map['datas'] = datas?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['over'] = over;
    map['pageCount'] = pageCount;
    map['size'] = size;
    map['total'] = total;
    return map;
  }

}

/// author : "郭霖"
/// chapterId : 409
/// chapterName : "郭霖"
/// courseId : 13
/// desc : ""
/// envelopePic : ""
/// id : 341914
/// link : "https://mp.weixin.qq.com/s/gNP92eyl-5n-JEz1pvdX0w"
/// niceDate : "7分钟前"
/// origin : ""
/// originId : 29068
/// publishTime : 1729587935000
/// title : "Android 15 正式发布至 AOSP"
/// userId : 164293
/// visible : 0
/// zan : 0

class CollectItemData {
  CollectItemData({
      this.author, 
      this.chapterId, 
      this.chapterName, 
      this.courseId, 
      this.desc, 
      this.envelopePic, 
      this.id, 
      this.link, 
      this.niceDate, 
      this.origin, 
      this.originId, 
      this.publishTime, 
      this.title, 
      this.userId, 
      this.visible, 
      this.zan,});

  CollectItemData.fromJson(dynamic json) {
    author = json['author'];
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    courseId = json['courseId'];
    desc = json['desc'];
    envelopePic = json['envelopePic'];
    id = json['id'];
    link = json['link'];
    niceDate = json['niceDate'];
    origin = json['origin'];
    originId = json['originId'];
    publishTime = json['publishTime'];
    title = json['title'];
    userId = json['userId'];
    visible = json['visible'];
    zan = json['zan'];
  }
  String? author;
  num? chapterId;
  String? chapterName;
  num? courseId;
  String? desc;
  String? envelopePic;
  num? id;
  String? link;
  String? niceDate;
  String? origin;
  num? originId;
  num? publishTime;
  String? title;
  num? userId;
  num? visible;
  num? zan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['author'] = author;
    map['chapterId'] = chapterId;
    map['chapterName'] = chapterName;
    map['courseId'] = courseId;
    map['desc'] = desc;
    map['envelopePic'] = envelopePic;
    map['id'] = id;
    map['link'] = link;
    map['niceDate'] = niceDate;
    map['origin'] = origin;
    map['originId'] = originId;
    map['publishTime'] = publishTime;
    map['title'] = title;
    map['userId'] = userId;
    map['visible'] = visible;
    map['zan'] = zan;
    return map;
  }

}