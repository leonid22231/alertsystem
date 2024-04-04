// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ForumEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForumEntity _$ForumEntityFromJson(Map<String, dynamic> json) => ForumEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : MessageEntity.fromJson(json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForumEntityToJson(ForumEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'lastMessage': instance.lastMessage,
    };
