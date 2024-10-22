import 'package:flutter/material.dart';
import 'package:wan_android_flutter/pages/auth/login_page.dart';
import 'package:wan_android_flutter/pages/auth/register_page.dart';
import 'package:wan_android_flutter/pages/my_collects/my_collects_page.dart';
import 'package:wan_android_flutter/pages/tab_page.dart';

//路由管理类
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.tab:
        return pageRoute(TabPage(), settings: settings);
      case RoutePath.loginPage:
        return pageRoute(LoginPage(), settings: settings);
      case RoutePath.registerPage:
        return pageRoute(RegisterPage(), settings: settings);
      case RoutePath.myCollectPage:
        return pageRoute(MyCollectsPage());
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

  //login 页面
  static const String loginPage = "/login_page";

  //register 页面
  static const String registerPage = "/register_page";

  //文章收藏页面
  static const String myCollectPage = "/my_collect_page";
}
