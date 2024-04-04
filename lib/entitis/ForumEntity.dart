import 'package:app/entitis/MessageEntity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ForumEntity.g.dart';

@JsonSerializable()
class ForumEntity{
  int id;
  String name;
  String? image;
  MessageEntity? lastMessage;
  ForumEntity({required this.id,required this.name, this.image, this.lastMessage});

  factory ForumEntity.fromJson(Map<String, dynamic> json) => _$ForumEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ForumEntityToJson(this);
}