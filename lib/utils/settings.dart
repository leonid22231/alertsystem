
import 'package:app/api/RestClient.dart';
import 'package:app/entitis/CountryEntity.dart';
import 'package:app/entitis/GlobalsSettingsEntity.dart';
import 'package:app/entitis/SettingValue.dart';
import 'package:app/entitis/enums/NotifyType.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/utils/firebase.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GlobalsSettings{
  static String apiKey = "4411d9c1f94b36b440a0a3d63ffad88f";
  /*
              SHARED ^(
              int: nType
              int: minMag
              int: mSystem
              int: cont
              int: timeR
              bool: allNotify
   */
  static GlobalsSettingsEntity? globalsSettingsEntity;
  static Future<void> loadGlobalsSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int nType = sharedPreferences.getInt("nType")??3;
    int minMag = sharedPreferences.getInt("minMag")??0;
    int mSystem = sharedPreferences.getInt("mSystem")??0;
    int cont = sharedPreferences.getInt("cont")??4;
    int timeR = sharedPreferences.getInt("timeR")??0;
    int countryId = sharedPreferences.getInt("countryId")??1;
    bool allNotify = sharedPreferences.getBool("allNotify")??false;
    globalsSettingsEntity = GlobalsSettingsEntity(nType: nType, minMag: minMag,mSystem: mSystem,cont: cont,timeR: timeR, allNotify: allNotify, countryId: countryId);

    debugPrint("Settings load ${globalsSettingsEntity.toString()}");
  }
  static Future<void> saveGlobalsSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setInt("nType", globalsSettingsEntity!.nType);
    sharedPreferences.setInt("minMag", globalsSettingsEntity!.minMag);
    sharedPreferences.setInt("mSystem", globalsSettingsEntity!.mSystem);
    sharedPreferences.setInt("cont", globalsSettingsEntity!.cont);
    sharedPreferences.setInt("timeR", globalsSettingsEntity!.timeR);
    sharedPreferences.setBool("allNotify", globalsSettingsEntity!.allNotify);
    sharedPreferences.setInt("countryId", globalsSettingsEntity!.countryId);
    Dio dio = Dio();
    RestClient client = RestClient(dio);

    client.saveSettings(FirebaseAuth.instance.currentUser!.uid, NotifyType.values[globalsSettingsEntity!.nType], 2+0.5*globalsSettingsEntity!.minMag, globalsSettingsEntity!.countryId);
    debugPrint("Settings saved");
  }

  static List<SettingValue> settingValues_1(BuildContext context) {
    List<String> names = [
      S.of(context).setting_item_1_1,
      S.of(context).setting_item_1_2,
      S.of(context).setting_item_1_3,
      S.of(context).setting_item_1_4,
      S.of(context).setting_item_1_5,
      S.of(context).setting_item_1_7,
    ];
    List<SettingValue> list = [];

    for(int i = 0; i < names.length; i++){
        bool isEnable = globalsSettingsEntity!.nType==i;
        list.add(SettingValue(name: names[i], isEnable: isEnable, onClick: (){
          globalsSettingsEntity!.nType = i;
          debugPrint("nType set $i");
        }));
    }
    return list;
  }
  static bool settingBool_1() {
      return globalsSettingsEntity!.allNotify;
  }
  static List<SettingValue> settingValues_4(BuildContext context) {
    List<String> names = [
      S.of(context).setting_item_4_3,
      S.of(context).setting_item_4_4,
      S.of(context).setting_item_4_5,
      S.of(context).setting_item_4_6,
      S.of(context).setting_item_4_7,
      S.of(context).setting_item_4_8,
      S.of(context).setting_item_4_9,
      S.of(context).setting_item_4_10,
      S.of(context).setting_item_4_11,
      S.of(context).setting_item_4_12,
      S.of(context).setting_item_4_13,
      S.of(context).setting_item_4_14,
      S.of(context).setting_item_4_15,
      S.of(context).setting_item_4_16,
      S.of(context).setting_item_4_17,
      S.of(context).setting_item_4_18,
    ];
    List<SettingValue> list = [];
    for(int i = 0; i < names.length; i++){
      bool isEnable = globalsSettingsEntity!.minMag==i;
      list.add(SettingValue(name: names[i], isEnable: isEnable, onClick: (){
        globalsSettingsEntity!.minMag = i;
        debugPrint("minMag set $i");
      }));
    }
    return list;
  }
  static List<SettingValue> settingValues_5(BuildContext context) {
    List<String> names = [
      S.of(context).setting_item_5_1,
      //S.of(context).setting_item_5_2,
      S.of(context).setting_item_5_3,
    ];
    List<SettingValue> list = [];
    for(int i = 0; i < names.length; i++){
      bool isEnable = globalsSettingsEntity!.mSystem==i;
      list.add(SettingValue(name: names[i], isEnable: isEnable, onClick: (){
        globalsSettingsEntity!.mSystem = i;
        debugPrint("mSystem set $i");
      }));
    }
    return list;
  }
  static Future<List<SettingValue>> settingValues_countries() async {
      Dio dio = Dio();
      RestClient client = RestClient(dio);
      List<CountryEntity> all = await client.findAll();
      all = all.reversed.toList();
      print("C size ${all.length}");
      List<SettingValue> list = [];
      for(int i = 0; i < all.length; i++){
        bool isEnable = globalsSettingsEntity!.countryId==all[i].id;
        list.add(SettingValue(name: all[i].name, isEnable: isEnable, onClick: (){
          globalsSettingsEntity!.countryId = all[i].id;
          debugPrint("timeR set $i");
        }));
      }
      return list;
  }
  static List<SettingValue> settingValues_10(BuildContext context) {
    List<String> names = [
      S.of(context).setting_item_10_1,
      S.of(context).setting_item_10_2,
      S.of(context).setting_item_10_3,
      S.of(context).setting_item_10_4,
    ];
    List<SettingValue> list = [];
    for(int i = 0; i < names.length; i++){
      bool isEnable = globalsSettingsEntity!.timeR==i;
      list.add(SettingValue(name: names[i], isEnable: isEnable, onClick: (){
        globalsSettingsEntity!.timeR = i;
        debugPrint("timeR set $i");
      }));
    }
    return list;
  }
}