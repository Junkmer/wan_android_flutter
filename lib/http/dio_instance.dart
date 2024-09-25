import 'package:dio/dio.dart';
import 'package:wan_android_flutter/http/http_method.dart';
import 'package:wan_android_flutter/http/print_log_interceptor.dart';
import 'package:wan_android_flutter/http/rsp_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;

  DioInstance._(); //静态私有构造方法

  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  final Dio _dio = Dio();
  final _defaultTime = const Duration(seconds: 30);

  void initDio({
    required String baseUrl,
    String? httpMethod = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
        method: httpMethod,
        baseUrl: baseUrl,
        connectTimeout: connectTimeout ?? _defaultTime,
        receiveTimeout: connectTimeout ?? _defaultTime,
        sendTimeout: connectTimeout ?? _defaultTime,
        responseType: responseType,
        contentType: contentType);
    //添加打印请求返回信息拦截器
    _dio.interceptors.add(PrintLogInterceptor());
    //添加统一返回值处理拦截器
    _dio.interceptors.add(ResponseInterceptor());
  }

  ///get 请求方法
  Future<Response> get({
    required String path,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.get(path,
        queryParameters: param,
        options: options ??
            Options(
                method: HttpMethod.GET, receiveTimeout: _defaultTime, sendTimeout: _defaultTime),
        cancelToken: cancelToken);
  }

  ///post 请求方法
  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.post(path,
        queryParameters: queryParameters,
        data: data,
        options: options ??
            Options(
                method: HttpMethod.GET, receiveTimeout: _defaultTime, sendTimeout: _defaultTime),
        cancelToken: cancelToken);
  }
}
