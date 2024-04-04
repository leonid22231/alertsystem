import 'package:app/entitis/CountryEntity.dart';
import 'package:app/entitis/enums/NotifyType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SettingsEntity.g.dart';

@JsonSerializable()
class SettingsEntity {
  int id;
  NotifyType notifyType;
  double minWarning;
  CountryEntity country;

  SettingsEntity({
   required this.id,required this.notifyType,required this.minWarning,required this.country
});

  factory SettingsEntity.fromJson(Map<String, dynamic> json) => _$SettingsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsEntityToJson(this);
}