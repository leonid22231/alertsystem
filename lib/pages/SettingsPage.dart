// ignore_for_file: file_names

import 'package:app/entitis/SettingEntity.dart';
import 'package:app/entitis/SettingEntityBool.dart';
import 'package:app/entitis/SettingEntityValues.dart';
import 'package:app/entitis/SettingValue.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/settings/SettingPage.dart';
import 'package:app/utils/globals.dart';
import 'package:app/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPage();
}
class _SettingsPage extends State<SettingsPage>{
  int? selectSetting;
  bool update = false;
  List<dynamic>? settings;
  @override
  void initState() {
    super.initState();
    () async {
      await Future.delayed(Duration.zero);
      // ignore: use_build_context_synchronously
      getSettings(context);
    }();
  }
  @override
  void dispose() {
    GlobalsSettings.saveGlobalsSettings();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: Text("Настройки", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
            ),
          body: Padding(
            padding: EdgeInsets.all(18.sp).copyWith(top: 30.sp),
            child: FutureBuilder(
              future: getSettings(context),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  settings = snapshot.data;
                  return ListView.separated(
                      itemBuilder: (context, index){
                        if(settings![index] is SettingEntityBool){
                          return _settingWidgetBool(settings![index] as SettingEntityBool);
                        }else if(settings![index] is SettingEntityValues){
                          if(!update && selectSetting!=null && settings![selectSetting!]!.name==settings![index].name){
                            SchedulerBinding.instance
                                .addPostFrameCallback((_) => setState(() {
                              selectSetting = index;
                            }));
                            update = true;
                          }
                          return _settingWidgetValues(settings![index] as SettingEntityValues, index);
                        }else if(settings![index] is Divider){
                          return const SizedBox.shrink();
                        }else if(settings![index] is SettingEntity){
                          return _settingWidget(settings![index]);
                        }
                        return const SizedBox.shrink();
                      },
                      separatorBuilder: (context, index){
                        if(settings![index] is Divider){
                          return SizedBox(height: 22.sp,);
                        }else{
                          return Divider(
                            height: 5.h,
                            color: Colors.black.withOpacity(0.06),
                          );
                        }
                      },
                      itemCount: settings!.length);
                }else{
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ),
        selectSetting!=null?NotificationListener<NotifyClose>(
          onNotification: (m){
            GlobalsSettings.saveGlobalsSettings();
            setState(() {
              selectSetting = null;
            });
            return true;
          },
            child: NotificationListener<NotifyUpdate>(
              onNotification: (m) {
                update = false;
                setState(() {

                });
                return true;
              },
              child: SettingPage(entity: settings![selectSetting!],),
            )
        ):const SizedBox.shrink()
      ],
    );
  }
  Future<List<Object>> getSettings(BuildContext context) async {
    List<SettingValue> values = await GlobalsSettings.settingValues_countries();
    return [
      SettingEntityValues(name: S.of(context).setting_item_1, values: GlobalsSettings.settingValues_1(context)),
      //SettingEntityValues(name: S.of(context).setting_item_2, values: values),
      SettingEntityBool(name: S.of(context).setting_item_3, isEnable: GlobalsSettings.settingBool_1(),onClick: (){
        GlobalsSettings.globalsSettingsEntity!.allNotify = !GlobalsSettings.globalsSettingsEntity!.allNotify;
        debugPrint("allNotify ${GlobalsSettings.globalsSettingsEntity!.allNotify}");
      }),
      SettingEntityValues(name: S.of(context).setting_item_4, values: GlobalsSettings.settingValues_4(context)),
      const Divider(),
      SettingEntityValues(name: S.of(context).setting_item_5, values: GlobalsSettings.settingValues_5(context)),
      SettingEntityValues(name: S.of(context).setting_item_7, values: values),
      //const Divider(),
      //SettingEntityValues(name: S.of(context).setting_item_8, values: values),
      //SettingEntityValues(name: S.of(context).setting_item_9, values: values),
      //SettingEntityValues(name: S.of(context).setting_item_10, values: GlobalsSettings.settingValues_10(context)),
      //SettingEntityValues(name: S.of(context).setting_item_11, values: values),
      const Divider(),
      SettingEntity(name: S.of(context).setting_item_16),
      SettingEntity(name: S.of(context).setting_item_12),
      SettingEntity(name: S.of(context).setting_item_13),
      SettingEntity(name: S.of(context).setting_item_14),
      SettingEntity(name: S.of(context).setting_item_15),
      const Divider()
    ];
  }
  Widget _settingWidgetValues(SettingEntityValues setting, int index){
    return InkWell(
      onTap: (){
        setState(() {
          selectSetting = index;
        });
      },
      child: SizedBox(
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(setting.name, style: TextStyle(fontSize: GlobalsWidget.fontSizes.smallSize,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.6)),),
            Row(
              children: [
                Text((setting.activeValue as SettingValue).name, style: TextStyle(fontSize: GlobalsWidget.fontSizes.smallSize,color: GlobalsWidget.gray3),),
                SizedBox(width: 5.w,),
                Icon(Icons.arrow_forward_ios, color: GlobalsWidget.eventSecondaryText,size: 5.w,)
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _settingWidgetBool(SettingEntityBool setting){
    final controller = ValueNotifier<bool>(setting.isEnable);
    controller.addListener(() {
      setting.onClick();
      setState(() {

      });
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(setting.name, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.6), fontSize: GlobalsWidget.fontSizes.smallSize)),
        AdvancedSwitch(
          controller: controller,
          activeColor: GlobalsWidget.redColor,
          inactiveColor: Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          width: 15.w,
          height: 3.5.h,
          enabled: true,
          disabledOpacity: 0.5,
        )
      ],
    );
  }
  Widget _settingWidget(SettingEntity setting){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(setting.name, style: TextStyle(fontSize: GlobalsWidget.fontSizes.smallSize,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.6))),
        Icon(Icons.arrow_forward_ios, color: GlobalsWidget.eventSecondaryText,size: 5.w,)
      ],
    );
  }
}