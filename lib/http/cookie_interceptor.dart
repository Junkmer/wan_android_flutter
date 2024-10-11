import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wan_android_flutter/constants.dart';
import 'package:wan_android_flutter/utils/sp_utils.dart';

import 'base_model.dart';

class CookieInterceptor extends Interceptor {
  bool isLogin = false;
  List<String?>? globalCookieList;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (globalCookieList == null || (isLogin && globalCookieList?.isEmpty == true)) {
      //取出本地cookie
      SpUtils.getStringList(Constants.SP_Cookie_List).then((cookieList) {
        globalCookieList = cookieList ?? [];
        //把本地缓存的cookie放入请求头
        options.headers[HttpHeaders.setCookieHeader] = cookieList;
        handler.next(options);
      });
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.path.contains("user/login")) {
      var rsp = BaseModel.fromJson(response.data);
      if (rsp.errorCode == 0) {
        //取出cookie信息
        dynamic list = response.headers[HttpHeaders.setCookieHeader];
        List<String> cookieList = [];
        if (list is List) {
          for (var value in list) {
            cookieList.add(value);
          }
        }
        globalCookieList = [];
        isLogin = true;
        SpUtils.saveStringList(Constants.SP_Cookie_List, cookieList);
      }
    }
    super.onResponse(response, handler);
  }
}
