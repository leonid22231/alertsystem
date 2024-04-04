import 'package:json_annotation/json_annotation.dart';

part 'UserEntity.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class UserEntity{
  @JsonKey(name: "name")
  String user_name;
  @JsonKey(name: "uid")
  String user_uid;
  UserEntity({required this.user_name, required this.user_uid});

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}