import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/pages/auth/login_page.dart';
import 'package:wan_android_flutter/pages/auth/register_page.dart';
import 'package:wan_android_flutter/pages/home/home_page.dart';
import 'package:wan_android_flutter/pages/tab_page.dart';
import 'package:wan_android_flutter/pages/web_view_page.dart';

//路由管理类
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.tab:
        return pageRoute(TabPage(),settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(WebViewPage(title: "title"),settings: settings);
      case RoutePath.loginPage:
        return pageRoute(LoginPage(),settings: settings);
      case RoutePath.registerPage:
        return pageRoute(RegisterPage(),settings: settings);
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
  static const String tab = "/";

  //WebView
  static const String webViewPage = "/web_view_page";

  //login 页面
  static const String loginPage = "/login_page";

  //register 页面
  static const String registerPage = "/register_page";
}
