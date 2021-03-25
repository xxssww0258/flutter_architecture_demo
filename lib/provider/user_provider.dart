import 'package:flutter/material.dart';

// 不要把所有Provider 都挂载到一起 刷新是按所有接触这个对象的一起刷新的
class UserInfoProvider with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  } 
}