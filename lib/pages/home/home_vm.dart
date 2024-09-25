import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/repository/api.dart';

import '../../repository/datas/home_banner_data.dart';
import '../../repository/datas/home_list_data.dart';

class HomeViewModel with ChangeNotifier {
  List<HomeBannerData?>? bannerList;
  List<HomeListItemData>? listData = [];

  //执行 异步或处理耗时任务时，建议通过创建 Future函数 配合 async 关键字 调用
  ///获取首页 banner数据
  Future getBanner() async {
    List<HomeBannerData?>? list = await Api.instance.getBanner();
    bannerList = list ?? [];
    notifyListeners();
  }

  Future initListData() async {
    await _getTopList();
    await _getHomeList();
    notifyListeners();
  }

  ///获取首页文章列表
  Future _getHomeList() async {
    List<HomeListItemData>? list = await Api.instance.getHomeList();
    listData?.addAll(list ?? []);
  }

  ///获取首页置顶数据
  Future _getTopList() async {
    List<HomeListItemData>? list = await Api.instance.getHomeTopList();
    listData?.clear();
    listData?.addAll(list ?? []);
  }
}
