import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/common_ui/SmartRefreshWidget.dart';
import 'package:wan_android_flutter/pages/knowledge/detail/knowledge_detail_vm.dart';

import '../../../common_ui/loading.dart';
import '../../../common_ui/web/webview_page.dart';
import '../../../common_ui/web/webview_widget.dart';
import '../../../repository/datas/knowledge_detail_list_data.dart';

class KnowledgeDetailTabChildPage extends StatefulWidget {
  const KnowledgeDetailTabChildPage({super.key, this.cid});

  final String? cid;

  @override
  State<StatefulWidget> createState() {
    return _KnowledgeDetailTabChildPageState();
  }
}

class _KnowledgeDetailTabChildPageState extends State<KnowledgeDetailTabChildPage> {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    Loading.showLoading();
    refreshOrLoad(false);
  }

  void refreshOrLoad(bool isLoadMore) {
    viewModel.getKnowledgeDetailList(widget.cid, isLoadMore).then((value) {
      if (isLoadMore) {
        viewModel.isOver == true
            ? refreshController.loadNoData()
            : refreshController.loadComplete();
      } else {
        refreshController.refreshCompleted(resetFooterState: true);
      }
      Loading.dismissAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return viewModel;
        },
        child: ChangeNotifierProvider(
          create: (context) {
            return viewModel;
          },
          child: Scaffold(
            body: Consumer<KnowledgeDetailViewModel>(builder: (context, vm, child) {
              return SmartRefreshWidget(
                controller: refreshController,
                onRefresh: () {
                  refreshOrLoad(false);
                },
                onLoading: () {
                  refreshOrLoad(true);
                },
                child: ListView.builder(
                    itemCount: viewModel.detailChildList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _item(viewModel.detailChildList?[index]);
                    }),
              );
            }),
          ),
        ));
  }

  Widget _item(KnowledgeDetailChildData? childData) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebviewPage(
                title: childData?.title,
                loadResource: childData?.link ?? "",
                webViewType: WebViewType.URL);
          }));
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5.r),
              borderRadius: BorderRadius.all(Radius.circular(5.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(childData?.superChapterName ?? "",
                      style: TextStyle(
                          color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                  Text(childData?.niceDate ?? "",
                      style: TextStyle(color: Colors.black, fontSize: 15.sp))
                ],
              ),
              SizedBox(height: 10.h),
              Text("\t\t\t\t\t${childData?.title ?? ""}",
                  style: TextStyle(color: Colors.black, fontSize: 14.sp)),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(childData?.chapterName ?? "",
                      style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                  Text(childData?.author ?? "",
                      style: TextStyle(color: Colors.black, fontSize: 15.sp))
                ],
              )
            ],
          ),
        ));
  }
}
