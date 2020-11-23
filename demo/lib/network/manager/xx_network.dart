

import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:demo/network/dio/http_config.dart';
import 'package:demo/network/dio/http_error.dart';
import 'package:demo/network/dio/http_util.dart';

/// 对网络层做一些处理 添加固定参数 打印请求、返回数据 特定异常处理
/// 单例shared
///
/// 返回Completer.future
class XXNetwork {


  factory XXNetwork() => shared;

  static final XXNetwork shared = XXNetwork._internal();

  XXNetwork._internal();

  Future post({String path, Map<String, dynamic> params, String tag}) async {
    path ??= HttpConfig.path;
    params ??= Map<String, dynamic>();
    params["version"] = HttpConfig.version;
    params["platform"] = HttpConfig.getPlatform();
    params["citycode"] = "103212";
    params["_corp_id"] = "1";
    params["corp_id"] = "1";
    params["user_id"] = 190;
    params["token"] = "143d175130459d1de3eed26e61b1934e";

    Completer completer = Completer();

    print("请求参数： ${params.toString()}");
    HttpUtil().post(path, params: params, resolve: (res) {
      print("返回数据： $res");
      if (res["code"] == 0) {
        completer.complete(res["data"]);
      } else {

      }
    }, reject: (HttpError error) {
      completer.completeError(error);
    }, cancelTag: tag);

    return completer.future;
  }

}