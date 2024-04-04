// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) =>
    MessageEntity(
      id: json['id'] as int,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      content: json['content'] as String,
      sentTime: DateTime.parse(json['sentTime'] as String),
      user: json['user'] == null
          ? null
          : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageEntityToJson(MessageEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'content': instance.content,
      'sentTime': instance.sentTime.toIso8601String(),
      'user': instance.user,
    };

const _$MessageTypeEnumMap = {
  MessageType.SERVER: 'SERVER',
  MessageType.USER: 'USER',
};
