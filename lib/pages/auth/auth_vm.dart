import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wan_android_flutter/constants.dart';
import 'package:wan_android_flutter/repository/datas/auth_data.dart';
import 'package:wan_android_flutter/utils/sp_utils.dart';

import '../../repository/api.dart';

class AuthViewModel with ChangeNotifier {
  RegisterInfo registerInfo = RegisterInfo();
  LoginInfo loginInfo = LoginInfo();

  Future<bool?> register() async {
    if (registerInfo.userName != null &&
        registerInfo.password != null &&
        registerInfo.rePassword != null &&
        registerInfo.password == registerInfo.rePassword) {
      if ((registerInfo.password?.length ?? 0) >= 6) {
        return await Api.instance.register(
            username: registerInfo.userName,
            password: registerInfo.password,
            repassword: registerInfo.rePassword);
      }
      showToast("密码长度必须大于等于6位数！");
      return false;
    }
    showToast("账号和密码为空或两次密码不一致");
    return false;
  }

  Future<bool?> login() async {
    if (loginInfo.userName != null && loginInfo.password != null) {
      AuthData? data =
          await Api.instance.login(username: loginInfo.userName, password: loginInfo.password);
      if (data != null) {
        //保存用户信息
        SpUtils.saveString(Constants.SP_User_Name, data.username ?? "");
        return true;
      } else {
        return false;
      }
    }
    showToast("账号或密码不能为空");
    return false;
  }

  void setLoginInfo({String? userName, String? password}) {
    loginInfo.userName = userName;
    loginInfo.password = password;
  }
}

class LoginInfo {
  String? userName;
  String? password;
}

class RegisterInfo {
  String? userName;
  String? password;
  String? rePassword;
}
