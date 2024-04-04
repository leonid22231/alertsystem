// ignore_for_file: file_names

import 'dart:math';

import 'package:app/api/RestClient.dart';
import 'package:app/entitis/EventEntity.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/utils/firebase.dart';
import 'package:app/utils/globals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HistoryPage extends StatefulWidget{
  const HistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryPage();
}
class _HistoryPage extends State<HistoryPage>{
  ScrollController scrollController = ScrollController();
  bool scroll = false;
  Random rnd = Random();
  bool is24HoursFormat = true;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    scrollController.addListener(() {
      if(scrollController.position.userScrollDirection==ScrollDirection.reverse){
        if(!scroll){
          setState(() {
            scroll = true;
          });
        }
      }else if(scrollController.position.userScrollDirection==ScrollDirection.forward){
        if(scroll){
          setState(() {
            scroll = false;
          });
        }
      }
    });
     return SafeArea(
         child: Padding(
           padding: EdgeInsets.all(5.w).copyWith(bottom: scroll?10.h:0),
           child: Column(
             children: [
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: GlobalsWidget.gray1,
                    hintText: S.of(context).history_input,
                    hintStyle: TextStyle(color: GlobalsWidget.gray3, fontSize: GlobalsWidget.fontSizes.smallSize),
                    prefixIcon: Icon(Icons.search, color: GlobalsWidget.gray3, size: GlobalsWidget.fontSizes.mainSize,),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset("assets/setting_input.svg"),
                      onPressed: _settingsButton,
                    ),
                    contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: GlobalsWidget.gray2),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: GlobalsWidget.gray2),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
               SizedBox(height: 3.h,),
               Expanded(
                   child: SizedBox(
                     child: SingleChildScrollView(
                       controller: scrollController,
                       child: FutureBuilder(
                         future: getHistory(),
                         builder: (context, snapshot){
                           if(snapshot.hasData){
                             List<Widget> list = _getNextDayWidget(snapshot.data!);
                             return Column(
                               children: [
                                 dayToday(snapshot.data!),
                                 SizedBox(height: 2.h,),
                                 list.isNotEmpty?dayYesterday(list):const SizedBox.shrink()
                               ],
                             );
                           }else{
                             print(snapshot.error);
                             return Center(child: Text("Загрузка..."),);
                           }
                         },
                       ),
                     ),
                   )
               )
             ],
           ),
         )
     );
  }
  Widget dayToday(List<EventEntity> list){
    List<Widget> _list = _getCurrentDayWidget(list);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${S.of(context).event_time_today}, ${DateFormat("dd MMMM").format(DateTime.now())}", style: TextStyle(fontSize: GlobalsWidget.fontSizes.bigSize, fontWeight: FontWeight.bold),),
        SizedBox(height: 2.h,),
        _list.isNotEmpty?ListView.builder(
            shrinkWrap: true,
            itemCount: _list.length,
            primary: false,
            itemBuilder: (context, index){
              return Column(
                children: [
                  _list[index],
                  Divider(color: Colors.black.withOpacity(0.06),),
                ],
              );
            }
        ):Align(
          alignment: Alignment.center,
          child: Text(S.current.event_not_found, style: TextStyle(fontSize: GlobalsWidget.fontSizes.mainSize, fontWeight: FontWeight.bold),),
        )
      ],
    );
  }
  Widget dayYesterday(List<Widget> list){
    DateTime currentDate = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${S.of(context).event_time_yesterday}, ${DateFormat("dd MMMM").format(currentDate.copyWith(day: currentDate.day - 1))}", style: TextStyle(fontSize: GlobalsWidget.fontSizes.bigSize, fontWeight: FontWeight.bold),),
        SizedBox(height: 2.h,),
        ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            primary: false,
            itemBuilder: (context, index){
              return Column(
                children: [
                  list[index],
                  Divider(color: Colors.black.withOpacity(0.06),),
                ],
              );
            }
        )
      ],
    );
  }
  List<Widget> _getCurrentDayWidget(List<EventEntity> list){
    List<Widget> _list = [];
    DateTime now = DateTime.now();
    list.map((e){
      if(e.createDate.day==now.day){
        _list.add(
          GlobalsWidget.eventWidget("${e.address.city!}, ${e.address.country}", e.type, e.createDate, e.value, is24HoursFormat)
        );
      }
    }).toList();
    return _list;
  }
  List<Widget> _getNextDayWidget(List<EventEntity> list){
    List<Widget> _list = [];
    DateTime now = DateTime.now();
    list.map((e){
      if(e.createDate.day==now.day-1){
        _list.add(
            GlobalsWidget.eventWidget("${e.address.city!}, ${e.address.country}", e.type, e.createDate, e.value,is24HoursFormat)
        );
      }
    }).toList();
    return _list;
  }
  Future<List<EventEntity>> getHistory(){
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    return client.getHistory(FirebaseGlobals.uid);
  }
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;

  void _settingsButton(){

  }
}