import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonalPageState();
  }
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        _header(),
        _widgetTab("我的收藏", onTap: () {}),
        _widgetTab("检查更新", onTap: () {}),
        _widgetTab("关于我们", onTap: () {}),
      ],
    )));
  }

  Widget _header() {
    return Container(
      color: Colors.teal,
      height: 220.h,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/ic_launcher.png", width: 50.r, height: 50.r),
          SizedBox(height: 5.h),
          Text("未登录", style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }

  Widget _widgetTab(String title, {GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 13.w, top: 10.h, right: 13.w),
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        alignment: Alignment.centerLeft,
        height: 45.h,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(5.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Colors.black)),
            Image.asset("assets/images/arrow_right.png", width: 15.w, height: 20.h)
          ],
        ),
      ),
    );
  }
}
