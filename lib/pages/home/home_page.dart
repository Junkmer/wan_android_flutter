import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/common_ui/loading.dart';
import 'package:wan_android_flutter/common_ui/web/webview_page.dart';
import 'package:wan_android_flutter/common_ui/web/webview_widget.dart';
import 'package:wan_android_flutter/pages/home/home_vm.dart';
import 'package:wan_android_flutter/route/routes.dart';

import '../../repository/datas/home_list_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    viewModel.getBanner();
    viewModel.initListData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            controller: refreshController,
            enablePullUp: true,
            enablePullDown: true,
            header: const ClassicHeader(),
            footer: const ClassicFooter(),
            onLoading: () {
              //上拉加载
              viewModel.loadMoreData().then((value) {
                bool loadFlag = value as bool;
                if (loadFlag) {
                  refreshController.loadComplete();
                } else {
                  // refreshController.loadFailed();
                  refreshController.loadNoData();
                }
              });
            },
            onRefresh: () {
              //下拉刷新
              viewModel.initListData().then((value) {
                bool refreshFlag = value as bool;
                if (refreshFlag) {
                  refreshController.refreshCompleted(resetFooterState: true);
                } else {
                  refreshController.refreshFailed();
                }
              });
            },
            child: SingleChildScrollView(
              //实现 banner 和 listview 一起滑动
              child: Column(
                children: [_banner(), _homeListView()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    return Consumer<HomeViewModel>(builder: (context, vm, child) {
      return SizedBox(
        height: 150.h,
        width: double.infinity,
        child: Swiper(
          indicatorLayout: PageIndicatorLayout.NONE,
          autoplay: true,
          pagination: const SwiperPagination(),
          control: const SwiperControl(),
          itemCount: vm.bannerList?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WebviewPage(
                      title: vm.bannerList?[index]?.title,
                      loadResource: vm.bannerList?[index]?.url ?? "",
                      webViewType: WebViewType.URL);
                }));
              },
              child: Container(
                height: 150.h,
                color: index == 0
                    ? Colors.lightBlue
                    : index == 1
                        ? Colors.lightGreen
                        : Colors.brown,
                child: Image.network(
                  vm.bannerList?[index]?.imagePath ?? "",
                  fit: BoxFit.fitWidth,
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _homeListView() {
    return Consumer<HomeViewModel>(builder: (context, vm, child) {
      return ListView.builder(
        shrinkWrap: true, //让dart 内部自行计算 listview 高度
        physics: const NeverScrollableScrollPhysics(), //禁用 listview自带的滑动事件，防止与 scrollView 冲突
        itemBuilder: (context, index) {
          return _listItemView(vm.listData?[index], index);
        },
        itemCount: vm.listData?.length ?? 0,
      );
    });
  }

  Widget _listItemView(HomeListItemData? itemData, int index) {
    String? name;
    if (itemData != null) {
      name = itemData.author?.isNotEmpty ?? false ? itemData.author : itemData.shareUser;
    } else {
      name = null;
    }

    // 控件增加点击事件，需要用 InkWell 或 GestureDetector 进行包裹
    // InkWell 点击会有水波纹，下面的默认没有，
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebviewPage(
              title: itemData?.title,
              loadResource: itemData?.link ?? "",
              webViewType: WebViewType.URL);
        }));
        // Navigator.pushNamed(context, RoutePath.webView);
        // Navigator.pushNamed(context, RoutePath.webViewPage, arguments: {"name": "使用路由传值"});
      },
      child: Container(
          margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
          padding: EdgeInsets.only(top: 15.h, bottom: 15.h, left: 10.w, right: 10.w),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0.5.r),
              borderRadius: BorderRadius.all(Radius.circular(6.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    name ?? "",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(itemData?.niceShareDate ?? "", style: const TextStyle(color: Colors.black)),
                  SizedBox(width: 10.w),
                  itemData?.type?.toInt() == 1
                      ? Text("置顶",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14.sp))
                      : const SizedBox()
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(itemData?.title ?? "", style: TextStyle(color: Colors.black, fontSize: 14.sp)),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemData?.chapterName ?? "",
                    style: TextStyle(color: Colors.green, fontSize: 12.sp),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (itemData != null) {
                        viewModel.collectOrUnCollect(itemData, index);
                      }
                    },
                    child: SizedBox(height: 25.h, child: _collectState(itemData?.collect)),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Widget _collectState(bool? flag) {
    if (flag == true) {
      return Image.asset("assets/images/collect_select.png", width: 25.r, height: 25.r);
    } else {
      return Image.asset("assets/images/collect_un_select.png", width: 20.r, height: 20.r);
    }
  }
}
