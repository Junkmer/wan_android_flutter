import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/pages/knowledge/detail/knowledge_detail_tab_child_page.dart';
import 'package:wan_android_flutter/pages/knowledge/detail/knowledge_detail_vm.dart';

import '../../../repository/datas/knowledge_data.dart';

class KnowledgeListDetailPage extends StatefulWidget {
  const KnowledgeListDetailPage({super.key, this.tabList});

  final List<KnowledgeChildren>? tabList;

  @override
  State<StatefulWidget> createState() {
    return _KnowledgeListDetailPageState();
  }
}

class _KnowledgeListDetailPageState extends State<KnowledgeListDetailPage>
    with SingleTickerProviderStateMixin {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabList?.length ?? 0, vsync: this);
    viewModel.initTabs(widget.tabList);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return viewModel;
    }, child: Consumer<KnowledgeDetailViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: TabBar(
                tabs: vm.tabs ?? [],
                controller: tabController,
                //设置 tab item 的文本颜色
                labelColor: Colors.blue,
                //设置 tab item 底部的滑块颜色
                indicatorColor: Colors.blue,
                //设置 tab item 是否可滑动
                isScrollable: true,
                //设置 tab 底部线条颜色透明
                dividerColor: Colors.transparent),
          ),
          body: SafeArea(
            child: TabBarView(controller: tabController, children: _childList()),
          ),
        );
      },
    ));
  }

  List<Widget> _childList() {
    return widget.tabList?.map((item) {
          return KnowledgeDetailTabChildPage(cid: "${item.id}");
        }).toList() ??
        [];
  }
}
