import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/pages/auth/auth_vm.dart';
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
  AuthViewModel viewModel = AuthViewModel();
  TextEditingController? usernameController;
  TextEditingController? passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return viewModel;
    }, child: Consumer<AuthViewModel>(builder: (context, vm, child) {
      return Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputBorder(hint: "输入账号", controller: usernameController),
              SizedBox(height: 10.h),
              inputBorder(hint: "输入密码", controller: passwordController),
              SizedBox(height: 40.h),
              submitBorderButton(
                  title: "开始登录",
                  onTap: () {
                    vm.setLoginInfo(
                        userName: usernameController?.text ?? "",
                        password: passwordController?.text ?? "");
                    vm.login().then((value) {
                      if (value == true) {
                        Navigator.popUntil(context, ModalRoute.withName(RoutePath.tab));
                      } else {
                        showToast("登录失败");
                      }
                    });
                  }),
              registerButton(onTap: () {
                Navigator.pushNamed(context, RoutePath.registerPage);
              })
            ],
          ),
        ),
      );
    }));
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
