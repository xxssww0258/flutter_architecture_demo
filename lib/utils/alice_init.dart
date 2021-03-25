import 'package:alice/alice.dart';

import 'application.dart';
import 'run_platform.dart';

class AliceInit {
  static final AliceInit _instance  = AliceInit._();
  factory AliceInit() => _instance;
  AliceInit._(){
    if((!RunPlatform.isProduction) && RunPlatform.isApp){
      Application.alice = Alice(showNotification: true, navigatorKey: Application.aliceKey);
      Application.dio.interceptors.add(Application.alice.getDioInterceptor());
    }
  }
}