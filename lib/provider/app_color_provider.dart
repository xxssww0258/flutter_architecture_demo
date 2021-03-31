import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppColorProvider with ChangeNotifier {
  
  static ThemeData getTheme(BuildContext context){
    return ThemeData(
      primaryColor: context.watch<AppColorProvider>().primary
    );
  }

  Color primary = Colors.blue[50];

  void changeColor(){
    notifyListeners();
  }
}