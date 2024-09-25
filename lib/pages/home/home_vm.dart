import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/datas/home_banner_data.dart';
import 'package:wan_android_flutter/datas/home_list_data.dart';
import 'package:wan_android_flutter/http/dio_instance.dart';
import 'package:wan_android_flutter/http/url_manager.dart';

class HomeViewModel with ChangeNotifier {
  List<BannerItemData>? bannerList;
  List<HomeListItemData>? listData;

  //执行 异步或处理耗时任务时，建议通过创建 Future函数 配合 async 关键字 调用
  //获取首页 banner数据
  Future getBanner() async {
    Response response = await DioInstance.instance().get(path: UrlManager.home_banner_path);
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
    Response response = await DioInstance.instance().get(path: UrlManager.home_list_path);
    HomeData homeData = HomeData.fromJson(response.data);
    if(homeData.data != null){
      listData = homeData.data?.datas;
    }else{
      listData = [];
    }

    notifyListeners();
  }
}
