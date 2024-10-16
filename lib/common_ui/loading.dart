import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class Loading {

  Loading._();

  static Future showLoading() async {
    print("Loading.......showLoading");
    showToastWidget(
        Container(
          color: Colors.transparent,
          constraints: const BoxConstraints.expand(),
          child: Align(
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Colors.black54),
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ),
        ),
        handleTouch: true,
        duration: const Duration(hours: 1));
  }

  static void dismissAll(){
    print("Loading.......dismissAll");
    dismissAllToast();
  }
}
