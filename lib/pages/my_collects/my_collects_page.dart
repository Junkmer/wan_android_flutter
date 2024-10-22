import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/pages/my_collects/my_collects_vm.dart';
import 'package:wan_android_flutter/repository/datas/collect_list_data.dart';

import '../../common_ui/web/webview_page.dart';
import '../../common_ui/web/webview_widget.dart';

///我的收藏页面
class MyCollectsPage extends StatefulWidget {
  const MyCollectsPage({super.key});

  @override
  State<StatefulWidget> createState() => MyCollectsPageState();
}

class MyCollectsPageState extends State<MyCollectsPage> {
  MyCollectsViewModel viewModel = MyCollectsViewModel();
  RefreshController controller = RefreshController();

  @override
  void initState() {
    super.initState();
    _loadDataOrRefresh(isRefresh: true);
  }

  void _loadDataOrRefresh({bool? isRefresh}) {
    viewModel.getCollectList(isRefresh: isRefresh).then((value) {
      if (isRefresh == true) {
        controller.refreshCompleted(resetFooterState: true);
      } else {
        controller.loadComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return viewModel;
    }, child: Scaffold(
      body: SafeArea(child: Consumer<MyCollectsViewModel>(builder: (context, vm, child) {
        return SmartRefresher(
            controller: controller,
            enablePullUp: true,
            enablePullDown: true,
            header: const ClassicHeader(),
            footer: const ClassicFooter(),
            onRefresh: () {
              _loadDataOrRefresh(isRefresh: true);
            },
            onLoading: () {
              _loadDataOrRefresh();
            },
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return _listItem(
                      itemData: vm.listData[index],
                      collectTap: () {
                        vm.unCollect(vm.listData[index].id ?? 0, index);
                      },
                      itemClick: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WebviewPage(
                              title: vm.listData[index].title,
                              loadResource: vm.listData[index].link ?? "",
                              webViewType: WebViewType.URL);
                        }));
                      });
                },
                itemCount: vm.listData.length));
      })),
    ));
  }

  Widget _listItem(
      {CollectItemData? itemData, GestureTapCallback? itemClick, GestureTapCallback? collectTap}) {
    return GestureDetector(
      onTap: itemClick,
      child: Container(
        padding: EdgeInsets.all(10.r),
        margin: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(itemData?.author ?? ""), Text("时间：${itemData?.niceDate}")]),
            SizedBox(height: 10.h),
            Text("        ${itemData?.title ?? ""}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            GestureDetector(
                onTap: collectTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(itemData?.chapterName ?? ""),
                    Image.asset(
                        "assets/images/collect_select"
                        ".png",
                        width: 25.w,
                        height: 25.h)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
