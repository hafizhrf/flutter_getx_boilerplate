import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class BaseResponse<T> {
  int? status;
  bool? success;
  @JsonKey(name: 'data')
  T? data;

  BaseResponse({this.status, this.success, this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$BaseResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T? value) toJsonT) => _$BaseResponseToJson(this, toJsonT);
}
