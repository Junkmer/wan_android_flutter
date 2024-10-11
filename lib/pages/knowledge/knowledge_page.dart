import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/pages/knowledge/knowledge_vm.dart';
import 'package:wan_android_flutter/repository/datas/knowledge_data.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _KnowledgePageState();
  }
}

class _KnowledgePageState extends State<KnowledgePage> {
  KnowledgeViewModel viewModel = KnowledgeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getKnowledgeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ChangeNotifierProvider(
        create: (context) {
          return viewModel;
        },
        child: Consumer<KnowledgeViewModel>(builder: (context, vm, child) {
          return ListView.builder(
            shrinkWrap: true, //让dart 内部自行计算 listview 高度
            padding: EdgeInsets.only(top: 10.h),
            itemBuilder: (context, index) {
              return _item(
                  title: vm.knowledgeList?[index].name,
                  childrenList: vm.knowledgeList?[index].children);
            },
            itemCount: vm.knowledgeList?.length ?? 0,
          );
        }),
      ),
    ));
  }

  Widget _item({String? title, List<KnowledgeChildren>? childrenList}) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5.r),
          borderRadius: BorderRadius.all(Radius.circular(5.r))),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? "",
                  style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.sp)),
              SizedBox(
                height: 5.h,
              ),
              Expanded(child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _subItem(name: childrenList?[index].name);
                },
                itemCount: childrenList?.length ?? 0,
              ))
            ],
          )),
          Image.asset("assets/images/arrow_right.png", width: 15.w, height: 20.h)
        ],
      ),
    );
  }

  Widget _subItem({String? name}) {
    return Text(
      name ?? "",
      style: TextStyle(color: Colors.grey, fontSize: 13.sp),
    );
  }
}
