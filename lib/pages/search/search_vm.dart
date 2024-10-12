import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/repository/datas/search_data.dart';

import '../../repository/api.dart';

class SearchViewModel extends ChangeNotifier {
  List<SearchItemListData>? listData = [];
  int pageCount = 0;
  //是否已分页拉取完全部数据
  bool isOver = false;

  Future search(String? key) async {
    pageCount = 0;
    var data = await Api.instance.search(key, pageCount);
    listData = data?.datas ?? [];
    isOver = data?.over ?? false;
    notifyListeners();
  }

  void cancelSearch() {
    listData?.clear();
    pageCount = 0;
    notifyListeners();
  }

  Future loadMore(String? key) async {
    var data = await Api.instance.search(key, pageCount++);
    if (data?.datas?.isNotEmpty == true) {
      listData?.addAll(data?.datas ?? []);
      isOver = data?.over ?? false;
      notifyListeners();
    } else {
      pageCount--;
    }
  }
}
