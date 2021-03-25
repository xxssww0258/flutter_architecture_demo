// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_db_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageDbInfoModel<T> _$PageDbInfoModelFromJson<T>(Map<String, dynamic> json) {
  return PageDbInfoModel<T>(
    pageNum: json['pageNum'] as int,
    pageSize: json['pageSize'] as int,
    pages: json['pages'] as int,
    total: json['total'] as int,
    list: (json['list'] as List)?.map(_Converter<T>().fromJson)?.toList(),
  );
}

Map<String, dynamic> _$PageDbInfoModelToJson<T>(PageDbInfoModel<T> instance) =>
    <String, dynamic>{
      'list': instance.list?.map(_Converter<T>().toJson)?.toList(),
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'pages': instance.pages,
      'total': instance.total,
    };
