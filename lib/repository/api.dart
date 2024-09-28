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
    Response response = await DioInstance.instance().get(path: "banner/json");
    HomeBannerListData bannerData = HomeBannerListData.fromJson(response.data);
    return bannerData.bannerList;
  }

  ///获取首页文章列表
  Future<List<HomeListItemData>?> getHomeList(int pageCount) async {
    Response response = await DioInstance.instance().get(path: "article/list/$pageCount/json");
    HomeListData homeData = HomeListData.fromJson(response.data);
    return homeData.datas;
  }

  ///获取首页文章置顶数据
  Future<List<HomeListItemData>?> getHomeTopList() async {
    Response response = await DioInstance.instance().get(path: "article/top/json");
    HomeTopListData homeData = HomeTopListData.fromJson(response.data);
    return homeData.topList;
  }

}
