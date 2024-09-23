import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebViewPage extends StatefulWidget {
  final String title;

  const WebViewPage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  String? name;

  @override
  void initState() {
    super.initState();

    //组件初始化完成后 再 获取路由参数
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var map = ModalRoute.of(context)?.settings.arguments;
      if (map is Map) {
        name = map["name"];
        setState(() {});//更新UI
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? widget.title),
      ),
      body: SafeArea(
        child: Container(
          child: InkWell(
            onTap: () {
              Navigator.pop(context); //返回上一页
            },
            child: Container(
              width: 200.w,
              height: 50.h,
              alignment: Alignment.center,
              child: Text("返回"),
            ),
          ),
        ),
      ),
    );
  }
}
