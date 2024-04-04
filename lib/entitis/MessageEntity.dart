import 'package:app/entitis/UserEntity.dart';
import 'package:app/entitis/enums/MessageType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MessageEntity.g.dart';

@JsonSerializable()
class MessageEntity{
  int id;
  MessageType type;
  String content;
  DateTime sentTime;
  UserEntity? user;

  MessageEntity({required this.id,required  this.type,required  this.content,required  this.sentTime, this.user});

  factory MessageEntity.fromJson(Map<String, dynamic> json) => _$MessageEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MessageEntityToJson(this);
}