import 'package:json_annotation/json_annotation.dart';

part 'AddressEntity.g.dart';

@JsonSerializable()
class  AddressEntity{
  int id;
  String country;
  String region;
  String? city;

  AddressEntity({required this.id,required this.country,required this.region, this.city});

  factory AddressEntity.fromJson(Map<String, dynamic> json) => _$AddressEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AddressEntityToJson(this);
}