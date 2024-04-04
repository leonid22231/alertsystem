// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SettingsEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsEntity _$SettingsEntityFromJson(Map<String, dynamic> json) =>
    SettingsEntity(
      id: json['id'] as int,
      notifyType: $enumDecode(_$NotifyTypeEnumMap, json['notifyType']),
      minWarning: (json['minWarning'] as num).toDouble(),
      country: CountryEntity.fromJson(json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingsEntityToJson(SettingsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notifyType': _$NotifyTypeEnumMap[instance.notifyType]!,
      'minWarning': instance.minWarning,
      'country': instance.country,
    };

const _$NotifyTypeEnumMap = {
  NotifyType.NOT: 'NOT',
  NotifyType.NEAR: 'NEAR',
  NotifyType.DISTANCE: 'DISTANCE',
  NotifyType.REGION: 'REGION',
  NotifyType.COUNTRY: 'COUNTRY',
  NotifyType.ALL: 'ALL',
};
