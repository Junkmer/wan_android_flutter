import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

///需要加载的内容类型
enum WebViewType {
  //html文本
  HTMLTEXT,
  //链接
  URL
}

///定义js通信回调方法
typedef dynamic JsChannelCallback(List<dynamic> arguments);

///封装的WebView组件
class WebviewWidget extends StatefulWidget {
  const WebviewWidget(
      {super.key,
      required this.webViewType,
      required this.loadResource,
      this.clearCache,
      this.jsChannelMap,
      this.onWebViewCreated});

  //需要加载的内容类型
  final WebViewType webViewType;

  //给webview加载的数据，可以是url，也可以是html文本
  final String loadResource;

  //是否清除缓存后再加载
  final bool? clearCache;

  //与js通信的channel集合
  final Map<String, JsChannelCallback>? jsChannelMap;

  final Function(InAppWebViewController controller)? onWebViewCreated;

  @override
  State<StatefulWidget> createState() {
    return _WebviewWidgetState();
  }
}

class _WebviewWidgetState extends State<WebviewWidget> {
  //webview控制器
  late InAppWebViewController webViewController;
  final GlobalKey webViewKey = GlobalKey();

  // webview配置
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      // 跨平台配置
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true, mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
          //不允许缩放
          builtInZoomControls: false,
          //支持HybridComposition
          useHybridComposition: true),
      ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      key: webViewKey,
      initialOptions: options,
      onWebViewCreated: (controller) {
        //webview初始化完成之后加载数据
        webViewController = controller;

        //是否清除缓存后再加载
        if (widget.clearCache == true) {
          controller.clearCache();
        }

        if (widget.onWebViewCreated == null) {
          if (widget.webViewType == WebViewType.HTMLTEXT) {
            webViewController.loadData(data: widget.loadResource);
          } else if (widget.webViewType == WebViewType.URL) {
            webViewController.loadUrl(urlRequest: URLRequest(url: Uri.parse(widget.loadResource)));
          }
        } else {
          widget.onWebViewCreated?.call(controller);
        }

        //注册与js通信回调
        widget.jsChannelMap?.forEach((handlerName, callback) {
          webViewController.addJavaScriptHandler(handlerName: handlerName, callback: callback);
        });
      },
      onConsoleMessage: (controller, consoleMessage) {
        //这里是打印来自js的console.log打印
        log("consoleMessage ===来自于js的打印=== \n $consoleMessage");
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {},
      onLoadStart: (InAppWebViewController controller, Uri? url) {},
      onLoadError: (InAppWebViewController controller, Uri? url, int code, String message) {},
      onLoadStop: (InAppWebViewController controller, Uri? url) {},
      onPageCommitVisible: (InAppWebViewController controller, Uri? url) {},
    );
  }
}
