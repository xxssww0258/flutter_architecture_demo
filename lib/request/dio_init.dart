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
  // TODO:
  static const String PEM = '''
-----BEGIN CERTIFICATE-----
MIIGRDCCBSygAwIBAgIMSn61QLc4mJsDtbx/MA0GCSqGSIb3DQEBCwUAMEwxCzAJ
BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlB
bHBoYVNTTCBDQSAtIFNIQTI1NiAtIEcyMB4XDTIxMDMwMzA2MzY0MloXDTIyMDQw
NDA2MzY0MlowHDEaMBgGA1UEAwwRKi5jb2NrZmlnaHRiZXQuY2MwggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDPzUSc4TfQWOY0MIbestDpd0ScOoLTQJMP
sIcYuyZlondQyQF6iljOgj+hneDrw/MkbAkfVRixye4XqWpp046v8jLruuqP5abG
V7mLRte/lk+yJ4tPBXL/33hA3TTloR7ECDjCIpqP22BnZGHeuZNAGs1nOqMJZnyJ
TZUu7rJXiu5Pt223h7Wn8p6bWJo+ojfwP/ziq6tbKPB6EgEAmzveRja6+KvvYDip
rUFxLfdfJEdEPR/taEf2JDAj0s0huHHxifOewqP1cO7hWrCJIOTotplgupacrJl0
KBqv2aJe3+t3SPqqTojHBK3mughMcZyLAjstVcsD1Sf7Gv/JqW5NAgMBAAGjggNU
MIIDUDAOBgNVHQ8BAf8EBAMCBaAwgYkGCCsGAQUFBwEBBH0wezBCBggrBgEFBQcw
AoY2aHR0cDovL3NlY3VyZTIuYWxwaGFzc2wuY29tL2NhY2VydC9nc2FscGhhc2hh
MmcycjEuY3J0MDUGCCsGAQUFBzABhilodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NhbHBoYXNoYTJnMjBXBgNVHSAEUDBOMEIGCisGAQQBoDIBCgowNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8w
CAYGZ4EMAQIBMAkGA1UdEwQCMAAwPgYDVR0fBDcwNTAzoDGgL4YtaHR0cDovL2Ny
bDIuYWxwaGFzc2wuY29tL2dzL2dzYWxwaGFzaGEyZzIuY3JsMC0GA1UdEQQmMCSC
ESouY29ja2ZpZ2h0YmV0LmNjgg9jb2NrZmlnaHRiZXQuY2MwHQYDVR0lBBYwFAYI
KwYBBQUHAwEGCCsGAQUFBwMCMB8GA1UdIwQYMBaAFPXN1TwIUPlqTzq3l9pWg+Zp
0mj3MB0GA1UdDgQWBBTwKBzT8RX1wPStkHSHYvDzxwD7vDCCAX4GCisGAQQB1nkC
BAIEggFuBIIBagFoAHcAb1N2rDHwMRnYmQCkURX/dxUcEdkCwQApBo2yCJo32RMA
AAF39s2QJgAABAMASDBGAiEArpKraL+POI0u9kuJ7vtI2QNLI3mnE8wmN17PfhAG
EnUCIQCaa0nkgfYYQgas3Dg1tesfNSNREKdWoCFyl43F67jZSgB1ACl5vvCeOTkh
8FZzn2Old+W+V32cYAr4+U1dJlwlXceEAAABd/bNkCwAAAQDAEYwRAIgC6OWAbzv
obwcnRtnDrMQUWkSEbTdLvEhbwJlinyBuf0CIAImVPXpJgWDEfOh4HGqqBmLCuZo
7G6MUdfWrRxfxxRAAHYAVYHUwhaQNgFK6gubVzxT8MDkOHhwJQgXL6OqHQcT0wwA
AAF39s2QTQAABAMARzBFAiB9j0FjXFucorv5pS+SFFXUEpzA1zqJ/MG0k41tuNrT
OQIhAMMsthiL/dTIu+pmg7NsNliQ6wP9hxxhKVfqn5ktjy6wMA0GCSqGSIb3DQEB
CwUAA4IBAQCUvnU5AoNbmJD3D0v5gk8lwi6kugFzxh16S6Et0Vwb+NwDEw9H9Uob
AReMyf3k8usriwU1GQgA2AdDGI6j5zsJM3KdR0tqonZ1RS9zEUxLFAEiFQG8/9Er
hhJNcdJHW9tsvXedC4as5a3/3TtdnxpNPOBlNjTLI/ni8y0rzn4ClGavBy7oYlDi
Bv8GwnaGBTxrxx86Ajd3e4t6rE5aUWCjBUT3QU34BHULLrA2NglEbgaz7vgXPU/f
10YvkdKTupst8BRGzUOqPM/ssqM0KzlasxyGWKnVYwxhzmXUrrCODI3mnMp6PHiK
NT4+PdaG/AvuKkj0+jiM2taXbgSgn90s
-----END CERTIFICATE-----
''';

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