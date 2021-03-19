import 'package:bot_toast/bot_toast.dart';
import 'application.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:r_upgrade/r_upgrade.dart';

import '../config.dart';
import '../utils/application.dart';
import '../utils/run_platform.dart';

class Upgrade {
  static final Dio dio = Application.dio;
  static AppVersionModel appVersionModel; // 这个是接口返回的模型
  
  // 检查升级条件 然后升级
  static checkUpgradeCondition(BuildContext context) async {
    S $S = S.of(context);

    if( !RunPlatform.isAndroid ) return; 
    // 调用 api 查询更新
    appVersionModel = await AppControllerDao.getAppVersion();
    
    // 修正版本比较方式
    List pkgVerArr = Application.packageInfo.version.split('.');
    List appVerArr = appVersionModel.versionCode.split('.');
    for(int i = 0; i < pkgVerArr.length; i++){
      int applicationVersionNumber = int.parse(pkgVerArr[i]);
      int originAppVersionNumber = int.parse(appVerArr[i]);
      if( (i == pkgVerArr.length - 1) && (applicationVersionNumber >= originAppVersionNumber) )  return ; // 最后一个版本比较 大于 等于
      if(applicationVersionNumber > originAppVersionNumber) return ; // 前2个只要比较大于
    }
    var cancelFunc = BotToast.showCustomLoading(
      // allowClick:true,
      // clickClose:true,
      toastBuilder:(_cancelFunc){
      return CupertinoAlertDialog(
        title: Text($S.whether_to_update_the_latest_version),
        actions: <Widget>[ // 有哪些行文按钮
          CupertinoDialogAction(child: Text($S.cancel),onPressed: _cancelFunc,),
          CupertinoDialogAction(child: Text($S.confirm),onPressed: () async {
            _cancelFunc();
            bool valid = await checkPermission(context);
            if(valid == false) return;
            downloadAndInstall();
          }),
        ],
      );
    });
  }

  /// 检查是否有权限，用于安卓
  static Future<bool> checkPermission(BuildContext context) async {
    S $S = S.of(context);

    // undetermined // 为定义
    // granted // 允许
    // restricted // 限制
    // denied // 拒绝
    // permanentlyDenied 
    PermissionStatus storageStatus = await Permission.storage.request();
    // if (storageStatus.isPermanentlyDenied) { // 永久拒绝
    //   print('你已拒绝,是否为你跳转到权限设置页');
    //   // 是
    //   openAppSettings();
    //   // 否
    // }
    
    if(storageStatus.isGranted){
      return true;
    }
    if (storageStatus.isRestricted) { // 限制
      BotToast.showText(text:$S.the_corresponding_permissions_are_restricted);
    }else{ // 其他就是拒绝
      BotToast.showText(text:$S.please_give_the_appropriate_permissions);
    }
    return false;

  }
  

  // 下载
  static downloadAndInstall()async{
    int id = await RUpgrade.upgrade(
      appVersionModel.updateUrl,
      fileName: '$SHOW_APP_NAME-${appVersionModel.versionCode}.apk',
      isAutoRequestInstall: true
    );

    // 还差网络判断
    RUpgrade.stream.listen((DownloadInfo info){
      if(info.id == id){
        // 当前下载状态
        // STATUS_PAUSED 下载已暂停
        // STATUS_PENDING等待下载
        // STATUS_RUNNING下载中
        // STATUS_SUCCESSFUL下载成功
        // STATUS_FAILED下载失败
        // STATUS_CANCEL下载取消
      }
    });
  }
}