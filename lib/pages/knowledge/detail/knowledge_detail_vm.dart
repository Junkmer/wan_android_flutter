import 'package:flutter/material.dart';

import '../../../repository/api.dart';
import '../../../repository/datas/knowledge_data.dart';
import '../../../repository/datas/knowledge_detail_list_data.dart';

class KnowledgeDetailViewModel with ChangeNotifier {
  List<Tab>? tabs = [];
  List<KnowledgeDetailChildData>? detailChildList = [];
  int _pageCount = 0;
  //是否已分页拉取完全部数据
  bool isOver = false;

  void initTabs(List<KnowledgeChildren>? tabList) {
    if (tabList?.isNotEmpty == true) {
      tabList?.forEach((item) {
        tabs?.add(Tab(
          text: item.name ?? "",
        ));
      });
    }
  }

  Future getKnowledgeDetailList(String? cid, bool isLoadMore) async {
    if (isLoadMore) {
      _pageCount++;
    } else {
      _pageCount = 0;
      detailChildList = [];
    }
    var knowledgeDetailData = await Api.instance.getKnowledgeDetailList(cid, _pageCount);
    var list = knowledgeDetailData?.datas;
    isOver = knowledgeDetailData?.over ?? false;
    if (list?.isNotEmpty == true) {
      detailChildList?.addAll(list ?? []);
      notifyListeners();
    } else {
      if (isLoadMore && _pageCount > 0) {
        _pageCount--;
      }
    }
  }
}
