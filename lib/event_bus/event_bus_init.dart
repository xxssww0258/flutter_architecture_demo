import 'package:flutter_architecture_demo/utils/run_platform.dart';

import 'event_bus.dart';

enum EventBusNames {
  sthEvent,// 某个事件
}
class EventBusInit {
  // 记录事件巴士的所有记录
  static logInit() {
    if(RunPlatform.isProduction) return;
    EventBus().on(EventBusNames.sthEvent, (arg) {
      print('========== EventBus：${EventBusNames.sthEvent} ========== ');
      // print(arg);
    });
  }
}
