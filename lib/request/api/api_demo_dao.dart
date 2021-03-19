import 'package:dio/dio.dart';
import 'package:flutter_architecture_demo/utils/application.dart';

class ApiDemoDao {
  static Dio _dio = Application.dio;
  static Future<dynamic> getApi() async {
    var result = _dio.get('/getApi');
    return result as bool;
  }
}