import 'package:dio/dio.dart';

class HomeViewModel {
  //执行 异步或处理耗时任务时，建议通过创建 Future函数 配合 async 关键字 调用
  static Future getBanner() async {
    var dio = Dio();
    dio.options = BaseOptions(
        method: "GET",
        baseUrl: "https://www.wanandroid.com/",
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30));
    Response response = await dio.get("banner/json");
    print(response.data);
  }
}
