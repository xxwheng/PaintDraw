import 'dart:io';
import 'package:demo/network/dio/http_config.dart';
import 'package:demo/network/dio/http_error.dart';
import 'package:dio/dio.dart';

typedef void XXHttpSuccessCallback(dynamic data);

typedef void XXHttpFailureCallback(HttpError err);

class HttpUtil {

  factory HttpUtil() => _getInstance();

  static HttpUtil _instance = HttpUtil._();

  HttpUtil._() {
    if (null == _dio) {
      BaseOptions options = defaultOptions();
      _dio = Dio(options);
    }
  }

  static HttpUtil _getInstance() {
    return _instance;
  }

  Dio _dio;

  ///同一个CancelToken可以用于多个请求，
  ///当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消，
  ///一个页面对应一个CancelToken。
  Map<String, CancelToken> _cancelTokenDic = Map<String, CancelToken>();

  BaseOptions defaultOptions() {
    return BaseOptions(baseUrl: HttpConfig.baseUrl, connectTimeout: 10000, receiveTimeout: 10000);
  }

  void post(String path, { data, Map<String, dynamic> params, String cancelTag, XXHttpSuccessCallback resolve, XXHttpFailureCallback reject}) async {
    _request(path, "POST", data: data, params: params, cancelTag: cancelTag, resolve: resolve, reject: reject);
  }

  void get(String path, { data, Map<String, dynamic> params, String cancelTag, XXHttpSuccessCallback resolve, XXHttpFailureCallback reject}) async {
    _request(path, "GET", data: data, params: params, cancelTag: cancelTag, resolve: resolve, reject: reject);
  }

  void _request(String path, String method, { data, Map<String, dynamic> params, String cancelTag, XXHttpSuccessCallback resolve, XXHttpFailureCallback reject}) async {
    Options options = Options(method: method);
    CancelToken cancelToken;
    if (null != cancelTag && cancelTag.isNotEmpty) {
      _cancelTokenDic[cancelTag] ??= CancelToken();
      cancelToken = _cancelTokenDic[cancelTag];
    }

    try {
      var res = await _dio.request(path, data: data, options: options, queryParameters: params, cancelToken: cancelToken);
      if (res.statusCode == HttpStatus.ok) {
        resolve(res.data);
      }
    } on DioError catch (error) {
      if (null != reject) {
        reject(HttpError.dioError(error));
      }
    } catch(err) {
      if (null != reject) {
        reject(HttpError(HttpError.UNKNOWN, "异常"));
      }
    }
  }

}