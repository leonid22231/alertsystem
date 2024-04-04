// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      user_name: json['name'] as String,
      user_uid: json['uid'] as String,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'name': instance.user_name,
      'uid': instance.user_uid,
    };
