import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppColorProvider with ChangeNotifier {
  // 内置一个取主题的
  static ThemeData getThemeData (BuildContext context){
    return ThemeData(
      primaryColor: context.read<AppColorProvider>().primary,
      textTheme: TextTheme(bodyText2: TextStyle(color: context.read<AppColorProvider>().primary,))
    );
  } 
  
  Color get primary => _primary;
  Color _primary = Colors.red;
  
  void changeColor(){
    notifyListeners();
  }
}