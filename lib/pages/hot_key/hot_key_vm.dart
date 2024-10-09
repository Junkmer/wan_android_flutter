import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:wan_android_flutter/repository/api.dart';

import '../../repository/datas/common_website_data.dart';
import '../../repository/datas/search_hot_keys_data.dart';

class HotKeyPageViewModel with ChangeNotifier {
  List<SearchHotKeysData>? hotKeyList;
  List<CommonWebsiteData>? websitelist;

  Future initData() async {
    try {
      Future.wait([_getHotKeyList(), _getWebsiteList()]).then((result) {
        ///等两次请求都成功返回之后再通知UI刷新
        notifyListeners();
      });
    } catch (e) {
      // 处理异常
      if (kDebugMode) {
        print('initData error, exception: $e');
      }
    }
  }

  ///获取热词
  Future _getHotKeyList() async {
    hotKeyList = await Api.instance.getHotKeyList();
  }

  ///获取常用网站
  Future _getWebsiteList() async {
    websitelist = await Api.instance.getWebsiteList();
  }
}
