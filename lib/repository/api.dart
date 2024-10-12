import 'package:dio/dio.dart';
import 'package:wan_android_flutter/repository/datas/auth_data.dart';
import 'package:wan_android_flutter/repository/datas/common_website_data.dart';
import 'package:wan_android_flutter/repository/datas/knowledge_data.dart';
import 'package:wan_android_flutter/repository/datas/knowledge_detail_list_data.dart';
import 'package:wan_android_flutter/repository/datas/search_hot_keys_data.dart';

import '../http/dio_instance.dart';
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

  ///获取热词
  Future<List<SearchHotKeysData>?> getHotKeyList() async {
    Response response = await DioInstance.instance().get(path: "hotkey/json");
    SearchHotKeysListData hotKeysListData = SearchHotKeysListData.fromJson(response.data);
    return hotKeysListData.keysList;
  }

  ///获取常用网站
  Future<List<CommonWebsiteData>?> getWebsiteList() async {
    Response response = await DioInstance.instance().get(path: "friend/json");
    CommonWebsiteListData websiteListData = CommonWebsiteListData.fromJson(response.data);
    return websiteListData.websiteList;
  }

  ///注册
  Future<bool?> register({String? username, String? password, String? repassword}) async {
    Response response = await DioInstance.instance().post(path: "user/register", queryParameters: {
      "username": username ?? "",
      "password": password ?? "",
      "repassword": repassword ?? "",
    });
    return response.data != null;
  }

  ///登录
  Future<AuthData?> login({String? username, String? password}) async {
    Response response = await DioInstance.instance()
        .post(path: "user/login", queryParameters: {"username": username, "password": password});
    AuthData authData = AuthData.fromJson(response.data);
    return authData;
  }

  ///获取体系列表数据
  Future<List<KnowledgeData>?> getKnowledgeList() async {
    Response response = await DioInstance.instance().get(path: "tree/json");
    KnowledgeListData knowledgeListData = KnowledgeListData.formJson(response.data);
    return knowledgeListData.knowledgeList;
  }

  ///收藏
  Future<bool?> collect(num id) async {
    Response response = await DioInstance.instance().post(path: "lg/collect/$id/json");
    return response.data;
  }

  ///取消收藏
  Future<bool?> unCollect(num id) async {
    Response response = await DioInstance.instance().post(path: "lg/uncollect_originId/$id/json");
    return response.data;
  }

  ///退出登录
  Future<bool?> logout() async {
    Response response = await DioInstance.instance().get(path: "user/logout/json");
    return response.data;
  }

  Future<KnowledgeDetailListData?> getKnowledgeDetailList(String? cid, int page) async {
    Response response =
        await DioInstance.instance().get(path: "article/list/$page/json", param: {"cid": cid});
    KnowledgeDetailListData listData = KnowledgeDetailListData.fromJson(response.data);
    return listData;
  }
}
