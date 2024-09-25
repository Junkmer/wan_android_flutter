import 'package:dio/dio.dart';

import '../http/dio_instance.dart';
import '../http/url_manager.dart';
import 'datas/home_banner_data.dart';
import 'datas/home_list_data.dart';

class Api {
  static Api instance = Api._();

  Api._();

  //执行 异步或处理耗时任务时，建议通过创建 Future函数 配合 async 关键字 调用
  ///获取首页 banner数据
  Future<List<HomeBannerData?>?> getBanner() async {
    Response response = await DioInstance.instance().get(path: UrlManager.home_banner_path);
    HomeBannerListData bannerData = HomeBannerListData.fromJson(response.data);
    return bannerData.bannerList;
  }

  ///获取首页文章列表
  Future<List<HomeListItemData>?> getHomeList() async {
    Response response = await DioInstance.instance().get(path: UrlManager.home_list_path);
    HomeListData homeData = HomeListData.fromJson(response.data);
    return homeData.datas;
  }

  ///获取首页文章置顶数据
  Future<List<HomeListItemData>?> getHomeTopList() async {
    Response response = await DioInstance.instance().get(path: UrlManager.home_top_list_path);
    HomeTopListData homeData = HomeTopListData.fromJson(response.data);
    return homeData.topList;
  }

}
