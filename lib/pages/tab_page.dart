import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_android_flutter/common_ui/navigation/navigation_bar_widget.dart';
import 'package:wan_android_flutter/pages/home/home_page.dart';
import 'package:wan_android_flutter/pages/hot_key/hot_key_page.dart';
import 'package:wan_android_flutter/pages/knowledge/knowledge_page.dart';
import 'package:wan_android_flutter/pages/personal/personal_page.dart';

import '../common_ui/navigation/navigation_bar_bean.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabPageState();
  }
}

class _TabPageState extends State<TabPage> {
  int currentIndex = 0;
  List<NavigationBarBean> beans = [];

  void initNavigationData() {
    beans.add(NavigationBarBean(
        page: HomePage(),
        label: "首页",
        icon: Image.asset("assets/images/demo_conversation_not_selected.png",
            width: 24.r, height: 24.r),
        activeIcon: Image.asset("assets/images/demo_main_tab_conversation_selected_serious.png",
            width: 28.r, height: 28.r)));
    beans.add(NavigationBarBean(
        page: HotKeyPage(),
        label: "热点",
        icon:
            Image.asset("assets/images/demo_community_not_selected.png", width: 24.r, height: 24.r),
        activeIcon: Image.asset("assets/images/demo_main_tab_community_selected_serious.png",
            width: 28.r, height: 28.r)));
    beans.add(NavigationBarBean(
        page: KnowledgePage(),
        label: "体系",
        icon: Image.asset("assets/images/demo_contact_not_selected.png", width: 24.r, height: 24.r),
        activeIcon: Image.asset("assets/images/demo_main_tab_contact_selected_serious.png",
            width: 28.r, height: 28.r)));
    beans.add(NavigationBarBean(
        page: PersonalPage(),
        label: "我的",
        icon: Image.asset("assets/images/demo_profile_not_selected.png", width: 24.r, height: 24.r),
        activeIcon: Image.asset("assets/images/demo_main_tab_profile_selected_serious.png",
            width: 28.r, height: 28.r)));
  }

  @override
  void initState() {
    super.initState();
    initNavigationData();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarWidget(
      beans: beans,
      onTabChange: (index) {
        print("index = $index");
      },
      position: currentIndex,
    );
  }
}
