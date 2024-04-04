import 'package:app/entitis/AddressEntity.dart';
import 'package:app/enums/EventType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EventEntity.g.dart';

@JsonSerializable()
class EventEntity{
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

  EventEntity({required this.id,required this.type, this.time,required this.radius,required this.value,
    required this.latitude,required this.longitude,required this.active,required this.createDate, this.endDate,required this.address});

  factory EventEntity.fromJson(Map<String, dynamic> json) => _$EventEntityFromJson(json);
  Map<String, dynamic> toJson() => _$EventEntityToJson(this);

}