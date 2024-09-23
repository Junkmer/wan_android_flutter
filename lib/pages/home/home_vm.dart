import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/datas/home_banner_data.dart';
import 'package:wan_android_flutter/datas/home_list_data.dart';

class HomeViewModel with ChangeNotifier {
  List<BannerItemData>? bannerList;
  List<HomeListItemData>? listData;
  var dio = Dio();

  HomeViewModel(){
    dio.options = BaseOptions(
        method: "GET",
        baseUrl: "https://www.wanandroid.com/",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30));
  }

  //执行 异步或处理耗时任务时，建议通过创建 Future函数 配合 async 关键字 调用
  //获取首页 banner数据
  Future getBanner() async {
    Response response = await dio.get("banner/json");
    HomeBannerData bannerData = HomeBannerData.fromJson(response.data);
    if (bannerData.data != null) {
      bannerList = bannerData.data;
    } else {
      bannerList = [];
    }

    notifyListeners(); //通知provider更新UI
  }

  //获取首页文章列表
  Future getHomeList() async{
    Response response = await dio.get("article/list/0/json");
    HomeData homeData = HomeData.fromJson(response.data);
    if(homeData.data != null){
      listData = homeData.data?.datas;
    }else{
      listData = [];
    }

    notifyListeners();
  }
}
