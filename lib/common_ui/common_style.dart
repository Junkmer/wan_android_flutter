import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//通用的输入框
Widget inputBorder(
    {required String hint, TextEditingController? controller, ValueChanged<String>? onChanged}) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    style: TextStyle(color: Colors.white, fontSize: 14.sp),
    //设置光标颜色
    cursorColor: Colors.white,
    decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.5.r)),
        //未获取焦点前边框
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.5.r)),
        //获取焦点后边框
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.r)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 0.5.r)),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 0.5.r))),
  );
}

//通用的提交确认输入框
Widget submitBorderButton({required String title, GestureTapCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(left: 40.w, right: 40.w),
      height: 40.h,
      decoration: BoxDecoration(
          border: Border.all(width: 0.5.r, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
      ),
    ),
  );
}
