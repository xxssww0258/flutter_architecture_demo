import '../models/user/downline_model.dart';
import '../models/user/transaction_model.dart';
import '../models/user/user_bet_history_model.dart';
import '../models/user/user_deposit_response_model.dart';
import '../models/user/user_withdraw_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'page_db_info_model.g.dart';

@JsonSerializable()
class PageDbInfoModel<T> {

  @_Converter() // 转化器 一般嵌套才使用
  List<T> list;

  int pageNum; // example: 1 页码，从1开始
  int pageSize; // example: 10 页面大小 默认10
  int pages; // example: 1 总页数
  int total; // example: 0 数据总条数


  PageDbInfoModel({
    this.pageNum,
    this.pageSize,
    this.pages,
    this.total,
    this.list
  });

  factory PageDbInfoModel.fromJson(Map<String, dynamic> json) => _$PageDbInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$PageDbInfoModelToJson(this);

}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if(T == UserBetHistoryModel){
      return UserBetHistoryModel.fromJson(json) as T;
    }
    if(T == DownLineModel){
      return DownLineModel.fromJson(json) as T;
    }
    if(T == UserWithdrawResponseModel){
      return UserWithdrawResponseModel.fromJson(json) as T;
    }
    if(T == UserDepositResponseModel){
      return UserDepositResponseModel.fromJson(json) as T;
    }
    if(T == TransactionModel){
      return TransactionModel.fromJson(json) as T;
    }
    // 缺少 获取提现记录 模型
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object;
  }
}