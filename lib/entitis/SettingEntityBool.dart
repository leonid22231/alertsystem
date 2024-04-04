// ignore_for_file: file_names

import 'package:app/entitis/SettingEntity.dart';

class SettingEntityBool extends SettingEntity{
  bool isEnable;
  Function() onClick;
  SettingEntityBool({required super.name, required this.isEnable, required this.onClick});
}