import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/pages/search/search_vm.dart';

import '../../common_ui/SmartRefreshWidget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.content});

  final String? content;

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  SearchViewModel viewModel = SearchViewModel();
  late TextEditingController inputController;
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
    inputController.text = widget.content ?? "";
    viewModel.search(widget.content);
  }

  void loadMore() {
    viewModel.loadMore(inputController.text).then((value) {
      viewModel.isOver == true ? refreshController.loadNoData() : refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
            create: (context) {
              return viewModel;
            },
            child: Column(
              children: [
                _headerView(onBack: () {
                  Navigator.of(context).pop();
                }, onCancel: () {
                  inputController.text = "";
                  viewModel.cancelSearch();
                }, onSubmitted: (value) {
                  viewModel.search(inputController.text);
                }),
                Expanded(child: Consumer<SearchViewModel>(
                  builder: (context, vm, child) {
                    return SmartRefreshWidget(
                      controller: refreshController,
                      enablePullDown: false,
                      onLoading: () {
                        loadMore();
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _listItem(vm.listData?[index].title, onTap: () {});
                        },
                        itemCount: viewModel.listData?.length ?? 0,
                      ),
                    );
                  },
                ))
              ],
            )),
      ),
    );
  }

  Widget _listItem(String? content, {GestureTapCallback? onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration:
              BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26, width: 1.w))),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
          child: Html(
            data: content ?? "",
            style: {'html': Style(fontSize: FontSize(15.sp))},
          ),
        ));
  }

  Widget _headerView(
      {GestureTapCallback? onBack,
      GestureTapCallback? onCancel,
      ValueChanged<String>? onSubmitted}) {
    return Container(
        color: Colors.teal,
        height: 50.h,
        child: Row(
          children: [
            GestureDetector(
              onTap: onBack,
              child: Container(
                padding: EdgeInsets.only(left: 15.w, right: 5.w, top: 10.h, bottom: 10.h),
                child: Image.asset("assets/images/back_icon.png", width: 25.w, height: 25.h),
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 7.h, bottom: 7.h),
              child: TextField(
                //设置输入的内容格式为文本
                keyboardType: TextInputType.text,
                //设置回车键为搜索
                textInputAction: TextInputAction.search,
                onSubmitted: onSubmitted,
                controller: inputController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.only(left: 15.w),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20.r))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20.r)))),
              ),
            )),
            GestureDetector(
              onTap: onCancel,
              child: Container(
                padding: EdgeInsets.all(10.r),
                child: Text("取消", style: TextStyle(fontSize: 13.sp, color: Colors.white)),
              ),
            )
          ],
        ));
  }
}
