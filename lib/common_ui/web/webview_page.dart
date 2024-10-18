import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_android_flutter/common_ui/web/webview_widget.dart';

///显示网页资源的页面
class WebviewPage extends StatefulWidget {
  const WebviewPage(
      {super.key,
      required this.loadResource,
      required this.webViewType,
      this.showTitle = true,
      this.title,
      this.jsChannelMap});

  //是否显示标题
  final bool? showTitle;

  //标题内容
  final String? title;

  //需要加载的内容类型
  final WebViewType webViewType;

  //非webview加载的数据，可以是 url，也可以是html文本
  final String loadResource;

  //与js通信的channel合集
  final Map<String, JsChannelCallback>? jsChannelMap;

  @override
  State<StatefulWidget> createState() {
    return _WebviewPageState();
  }
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.showTitle ?? false)
          ? AppBar(title: _buildAppBarTitle(widget.showTitle, widget.title))
          : null,
      body: SafeArea(
        child: WebviewWidget(
          webViewType: widget.webViewType,
          loadResource: widget.loadResource,
          jsChannelMap: widget.jsChannelMap,
        ),
      ),
    );
  }

  Widget _buildAppBarTitle(bool? showTitle, String? title) {
    var show = showTitle ?? false;
    return show
        ? Html(data: title ?? "", style: {
            //整体样式使用 html
            "html": Style(fontSize: FontSize(15.sp))
          })
        : const SizedBox.shrink();
  }
}
