import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:wan_android_flutter/pages/web_view_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: double.infinity,
              child: Swiper(
                indicatorLayout: PageIndicatorLayout.NONE,
                autoplay: true,
                pagination: const SwiperPagination(),
                control: const SwiperControl(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    height: 150.h,
                    color: index == 0
                        ? Colors.lightBlue
                        : index == 1
                            ? Colors.lightGreen
                            : Colors.brown,
                  );
                },
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return _listItemView();
              },
              itemCount: 10,
            ))
          ],
        ),
      ),
    );
  }

  Widget _listItemView() {
    // 控件增加点击事件，需要用 InkWell 或 GestureDetector 进行包裹
    // InkWell 点击会有水波纹，下面的默认没有，
    return GestureDetector(onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return WebViewPage(title: "首页传过来的值");
      }));
    },child: Container(
        margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
        padding: EdgeInsets.only(top: 15.h, bottom: 15.h, left: 10.w, right: 10.w),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.5.r),
            borderRadius: BorderRadius.all(Radius.circular(6.r))),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(
                    "https://pic.netbian.com/uploads/allimg/240528/214044-17169036445670.jpg",
                    width: 30.r,
                    height: 30.r,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "作者",
                  style: TextStyle(color: Colors.black),
                ),
                Expanded(child: SizedBox()),
                Text("2024-08.26 13:30", style: TextStyle(color: Colors.black)),
                SizedBox(width: 10.w),
                Text("置顶", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text("标题内容标题内容标题内容标题内容标题内容标题内容标题内容标题内容标题内容标题内容标题内容",
                style: TextStyle(color: Colors.black, fontSize: 14.sp)),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Text(
                  "分类",
                  style: TextStyle(color: Colors.green, fontSize: 12.sp),
                ),
                Expanded(child: SizedBox()),
                Image.asset("assets/images/collect_un_select.png", width: 20.r, height: 20.r)
              ],
            )
          ],
        )),);
  }
}
