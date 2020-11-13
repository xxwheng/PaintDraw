import 'package:dio/dio.dart';

class HttpError {

  ///HTTP 状态码
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int REQUEST_TIMEOUT = 408;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;
  static const int GATEWAY_TIMEOUT = 504;

  static const String HTTP_ERROR = "HTTP_ERROR";

  static const String NETWORK_ERROR = "NETWORK_ERROR";

  static const String CONNECT_TIMEOUT = "CONNECT_TIMEOUT";

  static const String SEND_TIMEOUT = "SEND_TIMEOUT";

  static const String RECEIVE_TIMEOUT = "RECEIVE_TIMEOUT";

  static const String PARSE_ERROR = "PARSE_ERROR";

  static const SSL_ERROR = "SSL_ERROR";

  static const CANCEL = "CANCEL";

  static const UNKNOWN = "UNKNOWN";

  String code;
  String message;

  HttpError(this.code, this.message);

  HttpError.dioError(DioError error) {
    message = error.message;
    switch (error.type) {

    /// It occurs when url is opened timeout.
      case DioErrorType.CONNECT_TIMEOUT:
        code = CONNECT_TIMEOUT;
        message = "网络连接超时，请检查网络设置";
        break;
    /// It occurs when url is sent timeout.
      case DioErrorType.SEND_TIMEOUT:
        code = SEND_TIMEOUT;
        message = "网络连接超时，请检查网络设置";
        break;
    ///It occurs when receiving timeout.
      case DioErrorType.RECEIVE_TIMEOUT:
        code = RECEIVE_TIMEOUT;
        message = "服务器异常，请稍后重试！";
        break;
    /// When the server response, but with a incorrect status, such as 404, 503...
      case DioErrorType.RESPONSE:
        code = HTTP_ERROR;
        message = "服务器异常，请稍后重试！";
        break;

    /// When the request is cancelled, dio will throw a error with this type.
      case DioErrorType.CANCEL:
        code = CANCEL;
        message = "请求已被取消";
        break;

    /// Default error type, Some other Error. In this case, you can
    /// use the DioError.error if it is not null.
      case DioErrorType.DEFAULT:
        code = UNKNOWN;
        message = "网络异常，请稍后重试！";
        break;
    }
  }

  @override
  String toString() {
    return 'HTTPERROR {code: $code, message: $message}';
  }
}