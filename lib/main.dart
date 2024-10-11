import 'package:flutter/material.dart';
import 'package:wan_android_flutter/http/cookie_interceptor.dart';
import 'package:wan_android_flutter/http/dio_instance.dart';
import 'package:wan_android_flutter/http/url_manager.dart';
import 'package:wan_android_flutter/utils/sp_utils.dart';

import 'app.dart';
import 'constants.dart';

void main() {
  DioInstance.instance().initDio(baseUrl: UrlManager.baseUrl);
  runApp(const MyApp());
}
