import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/pages/auth/auth_vm.dart';

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
  AuthViewModel viewModel = AuthViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return viewModel;
    }, child: Consumer<AuthViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: Colors.teal,
          body: Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                inputBorder(
                    hint: "输入账号",
                    onChanged: (value) {
                      viewModel.registerInfo.userName = value;
                    }),
                SizedBox(height: 10.h),
                inputBorder(
                    hint: "输入密码",
                    onChanged: (value) {
                      viewModel.registerInfo.password = value;
                    }),
                SizedBox(height: 10.h),
                inputBorder(
                    hint: "再次输入密码",
                    onChanged: (value) {
                      viewModel.registerInfo.rePassword = value;
                    }),
                SizedBox(height: 40.h),
                submitBorderButton(title: "点我注册",onTap: (){
                  viewModel.register().then((value){
                    if(value == true){
                      showToast("注册成功！");
                      //返回登录页面
                      Navigator.pop(context);
                    }
                  });
                }),
              ],
            ),
          ),
        );
      },
    ));
  }
}
