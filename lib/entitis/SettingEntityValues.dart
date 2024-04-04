// ignore_for_file: file_names

import 'package:app/entitis/SettingEntity.dart';
import 'package:app/entitis/SettingValue.dart';

class SettingEntityValues extends SettingEntity{
  List<SettingValue> values;
  SettingEntityValues({required super.name, required this.values});
  get activeValue{
    for(int i = 0; i < values.length; i++){
      if(values[i].isEnable){
        return values[i];
      }
    }
  }
}