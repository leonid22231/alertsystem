
// ignore_for_file: file_names

import 'package:app/entitis/SettingEntityValues.dart';
import 'package:app/entitis/SettingValue.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

//ignore: must_be_immutable
class SettingPage extends StatefulWidget{
  SettingEntityValues entity;
  SettingPage({required this.entity, super.key});

  @override
  State<StatefulWidget> createState() => _SettingPage();
}
class _SettingPage extends State<SettingPage>{
  @override
  Widget build(BuildContext context) {
    SettingEntityValues entityValues = widget.entity;
    return Scaffold(
      appBar: AppBar(
        title: Text(entityValues.name, style: TextStyle(fontSize: GlobalsWidget.fontSizes.mainSize, fontWeight: FontWeight.bold),),
        actions: [
          GestureDetector(
            onTap: (){
              NotifyClose().dispatch(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(S.of(context).button_back, style: TextStyle(fontSize: GlobalsWidget.fontSizes.mainSize,fontWeight: FontWeight.bold, color: GlobalsWidget.redColor),),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(6.w),
        child: SingleChildScrollView(
          child: ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return value(entityValues.values[index]);
              },
              separatorBuilder: (context,index){
                return Divider(height: 4.h,);
              },
              itemCount: entityValues.values.length),
        ),
      ),
    );
  }
  Widget value(SettingValue value){
    return InkWell(
      onTap: () async {
        value.onClick();
        NotifyUpdate().dispatch(context);
      },
      child: SizedBox(
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.name, style: TextStyle(fontSize: GlobalsWidget.fontSizes.smallSize,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.6)),),
            SizedBox(
              height: 6.w,
              width: 6.w,
              child: Checkbox(
                shape: const CircleBorder(),
                tristate: true,
                value: value.isEnable,
                onChanged: (value){
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class NotifyUpdate extends Notification{
  NotifyUpdate();
}
class NotifyClose extends Notification{
  NotifyClose();
}