import 'package:json_annotation/json_annotation.dart';
part 'app_info_model.g.dart';


/// 游戏场次信息
@JsonSerializable()
class AppInfoModel {
String aboutUsUrl; // example: http://cockfightonline.com/ 关于我们的URL
String appDownloadUrl; // example: http://cockfightonline.com/ 游戏下载地址
List<String> csList; //  [] 客服列表
List<String> marqueeList; //  [] 跑马灯字幕
int marqueeShowTime; // 字幕显示时间
String liveUrl; // example: https://wowzaprod236-i.akamaihd.net/hls/live/1019929/a5ff526c/playlist.m3u8 直播地址 // 目前还没使用 由于异步的原因
String shareContent; // example: 一起来玩cockFight吧,下载地址:https://www.xx.com/cf.apk 分享文案
String teamWorkUrl; // example: http://cockfightonline.com/ 合作URL
  AppInfoModel({
    this.aboutUsUrl,
    this.appDownloadUrl,
    this.csList,
    this.liveUrl,
    this.marqueeList,
    this.shareContent,
    this.teamWorkUrl,
    this.marqueeShowTime
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) => _$AppInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppInfoModelToJson(this);
}