import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/pages/auth/login_page.dart';
import 'package:wan_android_flutter/pages/personal/personal_vm.dart';
import 'package:wan_android_flutter/pages/tab_page.dart';
import 'package:wan_android_flutter/route/routes.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonalPageState();
  }
}

class _PersonalPageState extends State<PersonalPage> {
  PersonalViewModel viewModel = PersonalViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.setPersonalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Consumer<PersonalViewModel>(
        builder: (context, vm, child) {
          return Column(
            children: [
              _header(vm.username ?? "未登录"),
              _widgetTab("我的收藏", onTap: () {
                Navigator.pushNamed(context, RoutePath.myCollectPage);
              }),
              _widgetTab("检查更新", onTap: () {}),
              _widgetTab("关于我们", onTap: () {
                Navigator.pushNamed(context, RoutePath.aboutUsPage);
              }),
              viewModel.isLogin
                  ? _widgetTab("退出登录", onTap: () {
                      viewModel.logout().then((value) {
                        if (value == true) {
                          // 导航到新页面并移除所有页面
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const TabPage()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      });
                    })
                  : const SizedBox()
            ],
          );
        },
      ),
    )));
  }

  Widget _header(String username) {
    return Container(
      color: Colors.teal,
      height: 220.h,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          Navigator.pushNamed(context, RoutePath.loginPage);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/ic_launcher.png", width: 50.r, height: 50.r),
            SizedBox(height: 5.h),
            Text(username, style: TextStyle(color: Colors.white))
          ],
        ),
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
