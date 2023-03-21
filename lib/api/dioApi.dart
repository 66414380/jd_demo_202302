import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';

_parseAndDecode(String response) {
  /**
   * 自定义返回，下面代码可测试
   * '{"resultcode21":"101","reason":"错误的请求KEY","result":null,"error_code":10001}'
   */
  return jsonDecode(response);
}

parseJson(String text) {
  // 返回json String
  return compute(_parseAndDecode, text);
}

class DioClient extends DioForNative {
  static DioClient? _instance;
  factory DioClient() => _instance ??= DioClient._init();

  DioClient._init() {
    //Custom jsonDecodeCallback
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    options = BaseOptions(
      connectTimeout: 60 * 1000, //连接超时间
      receiveTimeout: 60 * 1000, //接收超时时间
    );
//处理访问前的拦截器
    interceptors.add(OptionInterceptor());
// //处理回来的数据
    interceptors.add(RequestInterceptor());
//代理抓包(开发阶段可能用到,正式上线建议关闭)
    // proxy();
  }

  ///get请求
  doGet<T>(path, {queryParameters, options, cancelToken, onReceiveProgress}) {
    return get<T>(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  ///post请求 为了不和继承的DioMixin里面的post方法名冲突所以起名叫doPost
  doPost<T>(path,
      {queryParameters,
        options,
        cancelToken,
        data,
        onSendProgress,
        onReceiveProgress}) {
    return post<T>(path,
        queryParameters: queryParameters,
        options: options,
        data: data,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  ///上传文件
  uploadFile(path, formData) {
    var uploadOptions = Options(contentType: "multipart/form-data");
    return doPost(path, options: uploadOptions, data: formData);
  }

  ///代理抓包测试用
  void proxy() {
    if (NetworkConfig.proxyEnable) {
      if (NetworkConfig.caughtAddress != "") {
        (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (client) {
          client.findProxy = (Uri uri) {
            return 'PROXY ' + NetworkConfig.caughtAddress;
          };
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            return true;
          };
        };
      }
    }
  }
}

class OptionInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//在请求发起前修改头部
// options.headers["token"] = "11111";
    ///请求的Content-Type，默认值是"application/json; charset=utf-8".
    /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
    options.contentType = Headers.formUrlEncodedContentType;

    ///如果你的headers是固定的你可以在BaseOption中设置,如果不固定可以在这里进行根据条件设置
    options.headers["apiToken"] = "111222154546";
    options.headers["user-token"] =
    CacheUtil().getJson(SPName.userInfo)!["userToken"];
    String mainUrl = CacheUtil().get<String>(SPName.mainUrl);
//修改地址
//如果需要改变主地址可以在这里设置

    if (StringUtil.isNotEmpty(mainUrl)) {
      options.baseUrl = mainUrl;
    } else {
      options.baseUrl = NetworkConfig.baseUrl;
    }
//开发阶段可以把地址带参数打印出来方便校验结果
    debugPrint(
        "request:${options.method}\t url-->${options.baseUrl}${options.path}?${FormatUtil.formattedUrl(options.queryParameters)}");

    if (options.queryParameters["hideLoading"] != true) {
      EasyLoading.show();
    }
// 一定要加上这句话 否则进入不了下一步
    return handler.next(options);
  }
}

///拦截器 数据初步处理
class RequestInterceptor extends InterceptorsWrapper {
//请求后 成功走这里
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    EasyLoading.dismiss();

    if (response.statusCode == 200) {
//访问正确有返回值的情况
      if (response.data is Map) {
//将数据脱壳需要返回自己的数据
        ResponseData responseData = ResponseData.fromJson(response.data);
        if (responseData.success) {
          print('${responseData.success}');
          response.data = responseData.data;
          response.statusCode = responseData.respCode;
          response.statusMessage = responseData.respDesc;
          return handler.resolve(response);
        }
        return handler.resolve(response);
      } else if (response.data is String) {
// {"respCode":403,"respDesc":"非法访问"}
        print('++++++++++${response.data}');
        ResponseError model = ResponseError.fromJson(jsonDecode(response.data));
        response.statusCode = model.respCode;
        if (model.respCode == 403 || model.respCode == 402) {
//做些什么
          throwUnauthorizedError(response);
        } else {
          throwError(response);
        }
      } else {
        throwError(response);
      }
    } else {
      throwError(response);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    EasyLoading.dismiss();

    throw DioError(
        requestOptions: err.requestOptions,
        type: err.type,
        error: err,
        response: err.response);
  }

  ///抛出异常 留给baseModel去统一处理
  void throwError(Response<dynamic> response) {
    throw DioError(
        requestOptions: response.requestOptions,
        error: ResponseException(errCode: response.statusCode));
  }
}

///鉴权错误
void throwUnauthorizedError(Response<dynamic> response) {
  throw DioError(
      requestOptions: response.requestOptions,
      error: UnauthorizedError(errCode: response.statusCode));
}

class UnauthorizedError {
  int? errCode;
  UnauthorizedError({this.errCode});
}

abstract class BaseResponseData {
  int? respCode;
  String? respDesc;
  dynamic attribute;
  dynamic data;
  bool get success;

  BaseResponseData({this.respCode, this.respDesc, this.attribute, this.data});

  @override
  // print 会打印下面代码
  String toString() {
    return 'BaseRespData{success:$success ,code: $respCode, message: $respDesc, data: $data}';
  }
}

class ResponseData extends BaseResponseData {
  @override
  bool get success => respCode != null || data != null;

  ResponseData.fromJson(Map<String, dynamic> json) {
    if (json['respCode'] != null && json['respCode'] is String) {
      json['respCode'] = int.parse(json['respCode']);
    }
    respCode = json['respCode'] ?? json['code'];
    respDesc = json['respDesc'] ?? json['message'] ?? json['msg'];
    attribute = json['attribute'] ?? json["data"];
    if (attribute != null) {
      if (attribute is Map && attribute.containsKey("data")) {
        data = attribute['data'];
      } else {
        data = attribute;
      }
    } else {
      // 如果 data 为空， success = false
      data = json;
    }
  }
}

class ResponseError extends BaseResponseData {
  ResponseError.fromJson(Map<String, dynamic> json) {
    respDesc = json["respDesc"];
    respCode = json["respCode"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["respDesc"] = respDesc;
    data["respCode"] = respCode;
    return data;
  }

  @override
// TODO: implement success
  bool get success => false;
}

class ResponseException implements Exception {
  int? errCode;
  String? errMsg;

  ResponseException({this.errCode});

  int? get errorCode => errCode;

//statusCode==200时候返回的data中存在的respCode
  String? get errorMessage {
    String msg = errMsg ?? "";
    switch (errCode) {
      default:
    }
    return msg;
  }

  @override
  String toString() {
    return 'RequestException{errorCode: $errorCode, errorMessage: $errorMessage}';
  }
}

class ErrorMessageModel {
  StateErrorType? errorType;
  String? message;
  int? errorCode;

  ErrorMessageModel({
    // this.errorType = StateErrorType.defaultError,
    this.message = "出错啦,请稍后重试~",
    this.errorCode,
  });

  ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    errorType = json['errorType'];
    message = json['message'];
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['errorType'] = errorType;
    data['message'] = message;
    data['errorCode'] = errorCode;
    return data;
  }
}

class NetworkConfig {
  static const bool proxyEnable = true;
  static const String baseUrl = 'http://apis.juhe.cn';
  static const String caughtAddress = '';
}

class EasyLoading {
  static show() {}
  static dismiss() {}
}

class StateErrorType {
  static StateErrorType? defaultError = aa();
  StateErrorType() {
    defaultError ??= StateErrorType.init();
  }
  StateErrorType.init() {
    // defaultError ??= StateErrorType.init();
  }
// factory StateErrorType() => defaultError ??= StateErrorType.init();
  static StateErrorType aa() {
    return defaultError ??= StateErrorType.init();
  }
}

class SPName {
  static const String userInfo = '';
  static const String mainUrl = 'http://apis.juhe.cn';
}

class CacheUtil {
  getJson(userInfo) {
    final Map<String, dynamic> data = {userInfo: {}};
    return data;
  }

  get<T>(url) {
    return url;
  }
}

class FormatUtil {
  static formattedUrl(queryParameters) {
    return queryParameters;
  }
}

class StringUtil {
  static isNotEmpty(String url) {
    return url.isNotEmpty ? true : false;
  }
}
