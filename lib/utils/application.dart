
import 'dart:io';

import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_demo/request/api/api_demo_dao2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';

import '../generated/l10n.dart';
class Application {
  static GlobalKey<NavigatorState> aliceKey = GlobalKey<NavigatorState>();
  static NavigatorState navigator = Navigator.of(Application.aliceKey.currentContext);
  static Dio dio = Dio(); 
  static RestClient client;
  static SharedPreferences sp;
  static S $S;
  // web不支持
  static Alice alice;
  static PackageInfo packageInfo;
  static Directory tempDir;
}