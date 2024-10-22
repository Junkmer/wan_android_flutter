import 'package:flutter/material.dart';
import 'package:wan_android_flutter/repository/datas/collect_list_data.dart';

import '../../repository/api.dart';

class MyCollectsViewModel with ChangeNotifier {
  List<CollectItemData> listData = [];
  int pageCount = 0;

  ///收藏文章列表
  Future getCollectList({bool? isRefresh}) async {
    if (isRefresh == true) {
      pageCount == 0;
    } else {
      pageCount++;
    }
    var value = await Api.instance.getCollectList(pageCount);
    if (value is CollectListData) {
      if (isRefresh == true) {
        listData.clear();
      }
      listData.addAll(value.datas ?? []);
    } else {
      pageCount--;
    }
    notifyListeners();
  }
}
