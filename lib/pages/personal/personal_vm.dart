import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/constants.dart';
import 'package:wan_android_flutter/utils/sp_utils.dart';
import '../../repository/api.dart';

class PersonalViewModel with ChangeNotifier {
  String? username;
  bool isLogin = false;

  Future setPersonalInfo() async {
    username = await SpUtils.getString(Constants.SP_User_Name);
    isLogin = username != null;
    notifyListeners();
  }

  Future<bool?> logout() async {
    var callback = await Api.instance.logout();
    if (callback == true) {
      SpUtils.removeAll();
      notifyListeners();
    }
    return callback;
  }
}
