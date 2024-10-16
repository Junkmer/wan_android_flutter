import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wan_android_flutter/repository/api.dart';

import '../../common_ui/loading.dart';
import '../../repository/datas/home_banner_data.dart';
import '../../repository/datas/home_list_data.dart';

class HomeViewModel with ChangeNotifier {
  int pageCount = 0;
  List<HomeBannerData?>? bannerList;
  List<HomeListItemData>? listData = [];

  //执行 异步或处理耗时任务时，建议通过创建 Future函数 配合 async 关键字 调用
  ///获取首页 banner数据
  Future getBanner() async {
    Loading.showLoading();
    List<HomeBannerData?>? list = await Api.instance.getBanner();
    bannerList = list ?? [];
    notifyListeners();
  }

  ///首次加载首页数据 及 刷新请求
  Future<bool?> initListData() async {
    try {
      List<HomeListItemData>? topList;
      List<HomeListItemData>? homeList;

      await Future.wait([_getTopList(), _getHomeList()]).then((List results) {
        topList = results[0] as List<HomeListItemData>;
        homeList = results[1] as List<HomeListItemData>;
      });

      List<HomeListItemData> combinedList = List.from(topList ?? [])..addAll(homeList ?? []);

      if (combinedList.isNotEmpty) {
        pageCount = 0;
        listData?.clear();
      }

      listData = combinedList;
    } catch (e) {
      // 处理异常
      if (kDebugMode) {
        print('initListData error, exception: $e');
      }
    }
    notifyListeners();
    Loading.dismissAll();
    return listData?.isNotEmpty;
  }

  ///加载更多逻辑处理
  Future<bool?> loadMoreData() async {
    pageCount++;
    List<HomeListItemData>? homeList = await _getHomeList();
    if (homeList == null || homeList.isEmpty) {
      pageCount--;
    }
    listData?.addAll(homeList ?? []);
    notifyListeners();
    return homeList?.isNotEmpty;
  }

  ///获取首页文章列表
  Future<List<HomeListItemData>?> _getHomeList() async {
    return await Api.instance.getHomeList(pageCount);
  }

  ///获取首页置顶数据
  Future<List<HomeListItemData>?> _getTopList() async {
    return await Api.instance.getHomeTopList();
  }

  ///收藏或取消收藏
  void collectOrUnCollect(HomeListItemData itemData, int index) {
    if (itemData.id != null) {
      if (itemData.collect == true) {
        _unCollect(itemData.id!, index);
      } else {
        _collect(itemData.id!, index);
      }
    }
  }

  ///收藏
  Future _collect(num id, int index) async {
    var value = await Api.instance.collect(id);
    if (value == true) {
      listData?[index].collect = true;
      notifyListeners();
    }
  }

  ///取消收藏
  Future _unCollect(num id, int index) async {
    var value = await Api.instance.unCollect(id);
    if (value == true) {
      listData?[index].collect = false;
      notifyListeners();
    }
  }
}
