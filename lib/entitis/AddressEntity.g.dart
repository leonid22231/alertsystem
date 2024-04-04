// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddressEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressEntity _$AddressEntityFromJson(Map<String, dynamic> json) =>
    AddressEntity(
      id: json['id'] as int,
      country: json['country'] as String,
      region: json['region'] as String,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$AddressEntityToJson(AddressEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
    };
