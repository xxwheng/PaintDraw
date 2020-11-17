import 'dart:io';

enum EnumNetConfig {
  dev,
  tester,
  online
}

class HttpConfig {

  static final EnumNetConfig env = EnumNetConfig.tester;

  static final version = "4.11";

  static final baseUrl = getBaseUrl();

  static final webUrl = getWebBaseUrl();

  static final path = "";



  static String getBaseUrl() {
    switch (env) {
      case EnumNetConfig.dev:
        return "http://api.dev.jjys168.com";
        break;
      case EnumNetConfig.tester:
        return "http://api.t.jjys168.com";
        break;
      case EnumNetConfig.online:
        return "https://m.jjys168.com/api/";
        break;
    }
    return "";
  }

  static String getWebBaseUrl() {
    switch (env) {
      case EnumNetConfig.dev:
        return "http://m.dev.jjys168.com";
        break;
      case EnumNetConfig.tester:
        return "http://m.t.jjys168.com";
        break;
      case EnumNetConfig.online:
        return "https://m.jjys168.com";
        break;
    }
    return "";
  }


  static String getPlatform() {
    if (Platform.isIOS) {
      return "2";//"""ios";
    } else if (Platform.isAndroid) {
      return "2";//"android";
    }
    return "unknown";
  }
}

