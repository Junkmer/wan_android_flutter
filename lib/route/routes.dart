import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/pages/home/home_page.dart';
import 'package:wan_android_flutter/pages/web_view_page.dart';

//路由管理类
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return pageRoute(HomePage(),settings: settings);
      case RoutePath.webView:
        return pageRoute(WebViewPage(title: "title"),settings: settings);
    }
    return pageRoute(Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("路由：${settings.name} 不存在"),
        ),
      ),
    ));
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
    bool? maintainState = true,
    bool? fullscreenDialog,
    bool? allowSnapshotting = true,
  }) {
    return MaterialPageRoute(
        builder: (context) {
          return page;
        },
        settings: settings,
        fullscreenDialog: fullscreenDialog ?? false,
        maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true);
  }
}

//自定义的 路由地址，主要用于上面 generateRoute 函数中界面加载判断
class RoutePath {
  //首页
  static const String home = "/";

  //WebView
  static const String webView = "/web_view_page";
}
