import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/pages/hot_key/hot_key_vm.dart';
import 'package:wan_android_flutter/pages/search/search_page.dart';
import 'package:wan_android_flutter/repository/datas/search_hot_keys_data.dart';

import '../../common_ui/web/webview_page.dart';
import '../../common_ui/web/webview_widget.dart';
import '../../common_ui/loading.dart';
import '../../repository/datas/common_website_data.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HotKeyPageState();
  }
}

typedef WebsiteClick = Function(String? title, String link);

class _HotKeyPageState extends State<HotKeyPage> {
  HotKeyPageViewModel viewModel = HotKeyPageViewModel();

  @override
  void initState() {
    super.initState();
    Loading.showLoading();
    viewModel.initData().then((value){
      Loading.dismissAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                //标题
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 0.5.r, color: Colors.grey),
                          bottom: BorderSide(width: 0.5.r, color: Colors.grey))),
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h, bottom: 15.h),
                  child: Row(
                    children: [
                      Text("搜索热词", style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                      const Expanded(child: SizedBox()),
                      Image.asset("assets/images/search_icon.png", width: 20.r, height: 20.r)
                    ],
                  ),
                ),
                //搜索热词
                Consumer<HotKeyPageViewModel>(builder: (context, vm, child) {
                  return _gridView(false, hotKeyList: vm.hotKeyList, itemTop: (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPage(
                                  content: value,
                                )));
                  });
                }),
                //标题
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 20.h),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 0.5.r, color: Colors.grey),
                          bottom: BorderSide(width: 0.5.r, color: Colors.grey))),
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h, bottom: 15.h),
                  child: Text("常用网站", style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                ),
                //常用网站
                Consumer<HotKeyPageViewModel>(builder: (context, vm, child) {
                  return _gridView(true, websiteList: vm.websitelist, websiteClick: (title, link) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return WebviewPage(
                          title: title, loadResource: link, webViewType: WebViewType.URL);
                    }));
                  });
                }),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _gridView(bool? isWebsite,
      {List<CommonWebsiteData>? websiteList,
      List<SearchHotKeysData>? hotKeyList,
      ValueChanged<String>? itemTop,
      WebsiteClick? websiteClick}) {
    return Container(
        margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //主轴间隔
              mainAxisSpacing: 10.r,
              //最大横轴范围
              maxCrossAxisExtent: 150.w,
              //宽高比
              childAspectRatio: 2.3,
              //横轴间隔
              crossAxisSpacing: 10.r),
          itemBuilder: (context, index) {
            if (isWebsite == true) {
              return _item(
                  name: websiteList?[index].name,
                  websiteClick: websiteClick,
                  link: websiteList?[index].link);
            } else {
              return _item(name: hotKeyList?[index].name, itemTop: itemTop);
            }
          },
          itemCount: isWebsite == true ? websiteList?.length ?? 0 : hotKeyList?.length ?? 0,
        ));
  }

  Widget _item(
      {String? name, ValueChanged<String>? itemTop, String? link, WebsiteClick? websiteClick}) {
    return GestureDetector(
        onTap: () {
          if (link != null) {
            websiteClick?.call(name, link);
          } else {
            itemTop?.call(name ?? "");
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5.r),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: Text(name ?? ""),
        ));
  }
}
