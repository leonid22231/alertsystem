import 'package:json_annotation/json_annotation.dart';

part 'CountryEntity.g.dart';

@JsonSerializable()
class CountryEntity{
  int id;
  String name;

  CountryEntity({required this.id,required this.name});

  factory CountryEntity.fromJson(Map<String, dynamic> json) => _$CountryEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CountryEntityToJson(this);
}