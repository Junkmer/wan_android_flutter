import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wan_android_flutter/constants.dart';
import 'package:wan_android_flutter/utils/sp_utils.dart';

import 'base_model.dart';

class CookieInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //把本地缓存的cookie放入请求头
    SpUtils.getStringList(Constants.SP_Cookie_List).then((cookieList) {
      options.headers[HttpHeaders.cookieHeader] = cookieList;
      handler.next(options);
    });
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
        SpUtils.saveStringList(Constants.SP_Cookie_List, cookieList);
      }
    }
    super.onResponse(response, handler);
  }
}
