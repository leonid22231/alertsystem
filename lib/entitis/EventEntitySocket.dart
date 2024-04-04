import 'package:app/entitis/AddressEntity.dart';
import 'package:app/entitis/EventEntity.dart';
import 'package:app/enums/EventType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EventEntitySocket.g.dart';

@JsonSerializable()
class EventEntitySocket{
  int id;
  EventType type;
  double? time;
  double radius;
  double value;
  double latitude;
  double longitude;
  bool active;
  DateTime createDate;
  DateTime? endDate;
  AddressEntity address;

  EventEntitySocket({required this.id,required this.type, this.time,required this.radius,required this.value,
    required this.latitude,required this.longitude,required this.active,required this.createDate, this.endDate,required this.address});

  factory EventEntitySocket.fromJson(Map<String, dynamic> json) => _$EventEntitySocketFromJson(json);
  Map<String, dynamic> toJson() => _$EventEntitySocketToJson(this);

  EventEntity toEventEntity(){
    return EventEntity(id: id, type: type, radius: radius, value: value, latitude: latitude, longitude: longitude, active: active, createDate: createDate, address: address);
  }
}