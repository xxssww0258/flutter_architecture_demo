
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'generated/l10n.dart';
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
              Provider<UserInfoProvider>(create: (_) => UserInfoProvider())
            ],
            child: MaterialApp(
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
            ),
          );
        }
      );
  }
}