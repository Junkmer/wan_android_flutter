import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_android_flutter/route/routes.dart';

import '../../common_ui/common_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Container(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputBorder(hint: "输入账号"),
            SizedBox(height: 10.h),
            inputBorder(hint: "输入密码"),
            SizedBox(height: 40.h),
            submitBorderButton(title: "开始登录"),
            registerButton(onTap: () {
              Navigator.pushNamed(context, RoutePath.registerPage);
            })
          ],
        ),
      ),
    );
  }

  Widget registerButton({GestureTapCallback? onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 45.w,
          height: 45.h,
          child: Text("注册", style: TextStyle(color: Colors.white, fontSize: 14.sp)),
        ));
  }
}
