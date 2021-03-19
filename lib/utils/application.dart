
import 'dart:io';

import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';

import '../generated/l10n.dart';
class Application {
  static GlobalKey<NavigatorState> aliceKey = GlobalKey<NavigatorState>();
  static NavigatorState navigator = Navigator.of(Application.aliceKey.currentContext);
  static Dio dio = new Dio(); 
  static SharedPreferences sp;
  // web不支持
  static Alice alice;
  static PackageInfo packageInfo;
  static Directory tempDir;
  static S $S;
}