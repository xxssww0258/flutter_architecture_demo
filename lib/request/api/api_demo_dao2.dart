import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/app_info_model.dart';

part 'api_demo_dao2.g.dart';

@RestApi() // 要有这个才会生成  api_demo_dao2.g.dart
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/cf/app/info")
  Future<AppInfoModel> getInfo();
  
}
