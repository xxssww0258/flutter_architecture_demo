import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'event_bus/event_bus_init.dart';
import 'my_app.dart';
import 'request/dio_init.dart';
import 'utils/alice_init.dart';
import 'utils/application.dart';
import 'utils/run_platform.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //FIXME： 如果main函数 是 async  就必须调用这个
  BASE_URL = 'http://www.baidu.com';
  Application.sp = await SharedPreferences.getInstance();
  EventBusInit.logInit();
  // 只支持部分平台
  if(RunPlatform.isAndroid || RunPlatform.isIOS || RunPlatform.isMacOS){
    Application.packageInfo = await PackageInfo.fromPlatform();
  }
  // 只支持部分平台
  if(RunPlatform.isAndroid || RunPlatform.isIOS || RunPlatform.isMacOS || RunPlatform.isWindows || RunPlatform.isLinux){
    Application.tempDir = await getTemporaryDirectory();
  }
  AliceInit();
  DioInit();

  runApp(MyApp());
}
