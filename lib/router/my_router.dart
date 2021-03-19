import 'package:flutter/material.dart';

import 'route_name.dart';

import '../pages/not_found_page/not_found_page.dart';
import '../pages/home_index_page/home_index_page.dart';
import '../pages/user/login_page/login_page.dart';

class MyRouter {
  /// 路由守卫
  static routeGuard(BuildContext context, {@required String routeName, @required Widget child} ){
    bool isLogin = true; // TODO: 修改
    // 白名单
    if(RouteName.WhiteList.contains(routeName)) return child;
    // 登陆判断
    if(isLogin) return child;
    // 不是白名单跳登录页
    return LoginPage();
  }

  /// 路由生成
  static MaterialPageRoute<T> generateRoute<T>(RouteSettings settings){
    WidgetBuilder builder;
    switch(settings.name){
      case RouteName.HomeIndexPage:
        builder = (context) => routeGuard(context, routeName: RouteName.HomeIndexPage, child: HomeIndexPage());
        break;
      case RouteName.LoginPage:
        builder = (context) => routeGuard(context, routeName: RouteName.LoginPage, child: LoginPage());
        break;
      default:
        builder = (context) => routeGuard(context, routeName: RouteName.NotFoundPage, child: NotFoundPage());
    }

    return MaterialPageRoute<T>(builder:builder,  settings: settings);
  }
  
}