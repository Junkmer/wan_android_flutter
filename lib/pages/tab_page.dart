import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_android_flutter/pages/home/home_page.dart';
import 'package:wan_android_flutter/pages/hot_key/hot_key_page.dart';
import 'package:wan_android_flutter/pages/knowledge/knowledge_page.dart';
import 'package:wan_android_flutter/pages/personal/personal_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabPageState();
  }
}

class _TabPageState extends State<TabPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: [HomePage(), HotKeyPage(), KnowledgePage(), PersonalPage()],
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(fontSize: 13.sp, color: Colors.black),
            unselectedLabelStyle: TextStyle(fontSize: 12.sp, color: Colors.blueGrey),
            currentIndex: currentIndex,
            items: _barItemList(),
            onTap: (index) {
              //点击切换页面
              currentIndex = index;
              setState(() {});
            },
          ),
        ));
  }

  List<BottomNavigationBarItem> _barItemList() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        label: "首页",
        icon: Image.asset("assets/images/demo_conversation_not_selected.png",
            width: 32.r, height: 32.r),
        activeIcon: Image.asset("assets/images/demo_main_tab_conversation_selected_serious.png",
            width: 32.r, height: 32.r)));
    items.add(BottomNavigationBarItem(
        label: "热点",
        icon:
            Image.asset("assets/images/demo_community_not_selected.png", width: 32.r, height: 32.r),
        activeIcon: Image.asset("assets/images/demo_main_tab_community_selected_serious.png",
            width: 32.r, height: 32.r)));
    items.add(BottomNavigationBarItem(
        label: "体系",
        icon: Image.asset("assets/images/demo_contact_not_selected.png", width: 32.r, height: 32.r),
        activeIcon: Image.asset("assets/images/demo_main_tab_contact_selected_serious.png",
            width: 32.r, height: 32.r)));
    items.add(BottomNavigationBarItem(
        label: "我的",
        icon: Image.asset("assets/images/demo_profile_not_selected.png", width: 32.r, height: 32.r),
        activeIcon: Image.asset("assets/images/demo_main_tab_profile_selected_serious.png",
            width: 32.r, height: 32.r)));
    return items;
  }
}
