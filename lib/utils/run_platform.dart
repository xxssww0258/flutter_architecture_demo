// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
import 'dart:io';

import 'package:flutter/foundation.dart';

class RunPlatform {
  static bool get isProduction => kReleaseMode; // 是否生产模式

  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
  static bool get isMobile => isAndroid || isIOS || isWeb;
  // static bool get isWeb => kIsWeb; // 目前仅适用于Android和iOS。
  static bool get isWeb => kIsWeb;
  static bool get isApp => isAndroid || isIOS; // 目前仅适用于Android和iOS。 建议用isWeb来判断
 
  static bool get isWindows {
    try{
      return Platform.isWindows;
    } catch(e){
      return false;
    }
  }
  static bool get isLinux {
    try{
      return Platform.isLinux;
    } catch(e){
      return false;
    }
  }
  static bool get isMacOS {
    try{
      return Platform.isMacOS;
    } catch(e){
      return false;
    }
  }
  static bool get isAndroid {
    try{
      return Platform.isAndroid;
    } catch(e){
      return false;
    }
  } 
  static bool get isFuchsia {
    try{
      return Platform.isFuchsia;
    } catch(e){
      return false;
    }
  } 
  static bool get isIOS {
    try{
      return Platform.isIOS;
    } catch(e){
      return false;
    }
  }
}