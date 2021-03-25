import 'dart:io';
import 'package:dio/adapter.dart';
// import 'package:dio/adapter_browser.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

import '../router/route_name.dart';
import '../config.dart';
import '../utils/application.dart';
import '../utils/run_platform.dart';
import 'package:dio/dio.dart';
// https://github.com/flutterchina/dio/blob/master/README-ZH.md

class DioInit {
  static final DioInit _instance  = DioInit._();
  factory DioInit() => _instance;

  static Dio dio = Application.dio;

  static setToken(String token){
    // TODO: 看情况是否要改
    if(token == null || token.isEmpty){
      throw ErrorDescription('token不能为空');
    }
    dio.options.headers['Authorization'] = token;
  }
  static removeToken(){
    // TODO: 看情况是否要改
    dio.options.headers.remove('Authorization');
  }
  
  static setLang(BuildContext context){
    // TODO: 看情况是否要改
    Locale locale = Localizations.localeOf(context);
    if(locale.languageCode.contains('zh')){
      dio.options.headers['lang'] = 'zh_CN';
    }else{
      dio.options.headers['lang'] = 'en_US';
    }
  }

  DioInit._(){
    dio.options.baseUrl = BASE_URL;
    dio.options.connectTimeout = API_TIMEOUT;
    dio.options.receiveTimeout = API_TIMEOUT;

    if(RunPlatform.isApp){ // 不确定是否只有app要这样设置
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
          client.badCertificateCallback=(X509Certificate cert, String host, int port){
            if(cert.pem == PEM){ // Verify the certificate
                return true;
            }
            return false;
          };
      };
    }else if(RunPlatform.isWeb){
      // FIXME: dio 3.0.10 存在bug 不能在 web外的环境声明 否则报错
      // dio.httpClientAdapter as BrowserHttpClientAdapter;
    }
    
    // ---------------------------------------- 拦截器 ----------------------------------------
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
        // 在请求被发送之前做一些事情
        return options; //continue

        // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
        //
        // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
        // 这样请求将被中止并触发异常，上层catchError会被调用。
      },
      onResponse:(Response response) async {
        if(response.headers.map['content-type'].first.contains('application/json')){
          // TODO: 增加返回的response 模型转换
          return response;
        }
        return response; 
      },
      onError: (DioError e) async {
         // 服务器返回的错误代码
        if(e.error == 'INTERNAL_ERROR'){
          // TODO: 
          BotToast.showText(text: '内部服务器错误');
        }else{
          // Http status error [404]
          BotToast.showText(text: e.message);
          // 后端放回401表示无权限跳登录
          if(e.response.statusCode == 401){
            return Application.navigator.pushNamedAndRemoveUntil(RouteName.LoginPage, (route)=>false);
          }
        }

        // 当请求失败时做一些预处理
        return e;//continue
      }
    ));
  }
}