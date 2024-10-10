import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_ui/common_style.dart';
import '../../route/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
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
            SizedBox(height: 10.h),
            inputBorder(hint: "再次输入密码"),
            SizedBox(height: 40.h),
            submitBorderButton(title: "点我注册"),
          ],
        ),
      ),
    );
  }
}
