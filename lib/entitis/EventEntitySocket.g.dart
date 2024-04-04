// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventEntitySocket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventEntitySocket _$EventEntitySocketFromJson(Map<String, dynamic> json) =>
    EventEntitySocket(
      id: json['id'] as int,
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      time: (json['time'] as num?)?.toDouble(),
      radius: (json['radius'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      active: json['active'] as bool,
      createDate: DateTime.parse(json['createDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      address: AddressEntity.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventEntitySocketToJson(EventEntitySocket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$EventTypeEnumMap[instance.type]!,
      'time': instance.time,
      'radius': instance.radius,
      'value': instance.value,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'active': instance.active,
      'createDate': instance.createDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'address': instance.address,
    };

const _$EventTypeEnumMap = {
  EventType.EARTHQUAKE: 'EARTHQUAKE',
  EventType.FIRE: 'FIRE',
  EventType.LANDSLIDE: 'LANDSLIDE',
  EventType.FLOODS: 'FLOODS',
  EventType.SEL: 'SEL',
  EventType.AVALANCHE: 'AVALANCHE',
};
