import 'package:dio/dio.dart';
import 'package:wan_android_flutter/datas/home_banner_data.dart';

class HomeViewModel {
  //执行 异步或处理耗时任务时，建议通过创建 Future函数 配合 async 关键字 调用
  static Future<List<BannerItemData>?> getBanner() async {
    var dio = Dio();
    dio.options = BaseOptions(
        method: "GET",
        baseUrl: "https://www.wanandroid.com/",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30));
    Response response = await dio.get("banner/json");
    HomeBannerData bannerData = HomeBannerData.fromJson(response.data);
    if(bannerData.data != null){
      return bannerData.data;
    }
    return [];
  }
}
