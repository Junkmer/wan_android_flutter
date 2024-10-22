import 'package:flutter/material.dart';
import 'package:wan_android_flutter/http/dio_instance.dart';
import 'package:wan_android_flutter/http/url_manager.dart';

import 'app.dart';

void main() {
  DioInstance.instance().initDio(baseUrl: UrlManager.baseUrl);
  runApp(const MyApp());
}
