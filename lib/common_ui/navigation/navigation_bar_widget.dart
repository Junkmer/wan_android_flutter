import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_android_flutter/common_ui/navigation/navigation_bar_item.dart';

import 'navigation_bar_bean.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key, required this.beans, this.onTabChange, this.position});

  final List<NavigationBarBean> beans;

  final ValueChanged<int>? onTabChange;

  final int? position;

  @override
  State<StatefulWidget> createState() {
    return _NavigationBarWidgetState();
  }
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.position ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: _getPages(),
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
          child: PreferredSize(
            preferredSize: Size.fromHeight(80.0), // 设置高度为 60.0
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(fontSize: 13.sp, color: Colors.black),
              unselectedLabelStyle: TextStyle(fontSize: 12.sp, color: Colors.blueGrey),
              currentIndex: currentIndex,
              items: _barItemList(),
              onTap: (index) {
                //点击切换页面
                currentIndex = index;
                widget.onTabChange?.call(index);
                setState(() {});
              },
            ),
          )
        ));
  }

  List<Widget> _getPages() {
    return widget.beans.map((bean) => bean.page).toList();
  }

  List<BottomNavigationBarItem> _barItemList() {
    List<BottomNavigationBarItem> items = [];
    for (var bean in widget.beans) {
      items.add(BottomNavigationBarItem(
          label: bean.label,
          icon: bean.icon,
          activeIcon: NavigationBarItem(
            builder: (context) {
              return bean.activeIcon;
            },
          )));
    }
    return items;
  }
}
