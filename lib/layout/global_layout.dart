import 'package:flutter/material.dart';

// import 'package:flutter_architecture_demo/utils/upgrade.dart';

import '../generated/l10n.dart';
import '../request/dio_init.dart';
import '../utils/application.dart';
import '../utils/run_platform.dart';

class GlobalLayout extends StatefulWidget {
  final Widget child;
  final BuildContext context;
  GlobalLayout(this.context, this.child);
  @override
  _GlobalLayoutState createState() => _GlobalLayoutState();
}

class _GlobalLayoutState extends State<GlobalLayout> {
  // static NavigatorState navigator = Navigator.of(Application.aliceKey.currentContext);
  @override
  void initState() {
    super.initState();
    // 初始化环境分2个地方 一个是不需要context的MyApp 另一个是需要context的GLobalLayout
    DioInit.setLang(widget.context); // Head国际化设置
    Application.$S = S.of(widget.context);
    
    initData(widget.context)
      .then((value){
        // TODO: 检查更新
        // Upgrade.checkUpgradeCondition(widget.context);
      });
  }
  // 初始化数据
  static Future initData(BuildContext context) async {
    return Future.wait([

    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:widget.child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RunPlatform.isProduction || RunPlatform.isWeb
        ? null
        : FloatingActionButton(onPressed: (){
            Application.alice?.showInspector();
          },  
          child: Text('debug')
        )
    );
  }
}