// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfoModel _$AppInfoModelFromJson(Map<String, dynamic> json) {
  return AppInfoModel(
    aboutUsUrl: json['aboutUsUrl'] as String,
    appDownloadUrl: json['appDownloadUrl'] as String,
    csList: (json['csList'] as List)?.map((e) => e as String)?.toList(),
    liveUrl: json['liveUrl'] as String,
    marqueeList:
        (json['marqueeList'] as List)?.map((e) => e as String)?.toList(),
    shareContent: json['shareContent'] as String,
    teamWorkUrl: json['teamWorkUrl'] as String,
    marqueeShowTime: json['marqueeShowTime'] as int,
  );
}

Map<String, dynamic> _$AppInfoModelToJson(AppInfoModel instance) =>
    <String, dynamic>{
      'aboutUsUrl': instance.aboutUsUrl,
      'appDownloadUrl': instance.appDownloadUrl,
      'csList': instance.csList,
      'marqueeList': instance.marqueeList,
      'marqueeShowTime': instance.marqueeShowTime,
      'liveUrl': instance.liveUrl,
      'shareContent': instance.shareContent,
      'teamWorkUrl': instance.teamWorkUrl,
    };
