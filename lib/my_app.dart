
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'generated/l10n.dart';
import 'provider/app_color_provider.dart';
import 'provider/user_provider.dart';
import 'router/my_router.dart';
import 'router/route_name.dart';
import 'utils/application.dart';
import 'layout/global_layout.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit(); 
    return 
      // 窗口适配
      ScreenUtilInit(
        designSize: DESIGN_SIZE,
        allowFontScaling: false,
        // 状态管理
        builder:(){
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<UserInfoProvider>.value(value:UserInfoProvider()),
              ChangeNotifierProvider<AppColorProvider>.value(value:AppColorProvider()),
              // Provider<UserInfoProvider>(create: (_) => UserInfoProvider()),
              // Provider<AppColorProvider>(create: (_) => AppColorProvider()),
            ],
            builder:(context, child){ // 这个child是上面 Provider  的其中一个参数 目前没有使用
              return MaterialApp(
                theme: AppColorProvider.getThemeData(context),
                themeMode: ThemeMode.light, // 系统主题 是 亮色 还是 暗色
                title: Application.packageInfo?.appName ?? SHOW_APP_NAME,
                builder: (BuildContext context, Widget child) => botToastBuilder(context,GlobalLayout(context, child)),
                navigatorObservers:[BotToastNavigatorObserver()],
                // http调试
                navigatorKey: Application.aliceKey,
                // 路由配置
                initialRoute: RouteName.HomeIndexPage,
                onGenerateRoute: MyRouter.generateRoute,
                localizationsDelegates: [
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,

                  S.delegate,// flutter intl生成的
                ],
                supportedLocales: S.delegate.supportedLocales,// mark
              );
            }
          );
        }
      );
  }
}