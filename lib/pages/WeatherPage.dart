// ignore_for_file: file_names

import 'package:app/generated/l10n.dart';
import 'package:app/utils/globals.dart';
import 'package:app/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather/weather.dart';

class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherPage();

}
class _WeatherPage extends State<WeatherPage> with SingleTickerProviderStateMixin{
  WeatherFactory wf = WeatherFactory(GlobalsSettings.apiKey);
  Future<Weather>? weather;
  Future<List<Weather>>? weatherNext;
  ScrollController scrollController = ScrollController();
  bool scroll = false;
  @override
  void initState() {
    super.initState();
    wf.language = Language.RUSSIAN;
    loadWeather(wf);
    loadWeatherNext(wf);
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
          child: Padding(
              padding: EdgeInsets.all(5.w).copyWith(bottom: scroll?10.h:0),
          child: FutureBuilder(
            future: weather,builder: (context, snapshot){
              if(snapshot.hasData){
                Weather weather = snapshot.data!;
                double precipitation = 0;
                if(!(weather.rainLast3Hours==null && weather.snowLast3Hours==null)){
                  if(weather.rainLast3Hours!=null){
                    precipitation = weather.rainLast3Hours!;
                  }else{
                    precipitation = weather.snowLast3Hours!;
                  }
                }
                DateTime currentDateTime = DateTime.now();
                return FutureBuilder(future: weatherNext, builder: (context, snapshot){
                  if(snapshot.hasData){
                    List<Weather> weatherNext = snapshot.data!;
                    List<List<Weather>> weathersByDay = [];
                    Weather currentWeather = weatherNext.first;
                    List<Weather> temp = [];
                    for(int i =0; i < weatherNext.length; i++){
                      if(currentWeather.date!.day==weatherNext[i].date!.day){
                        temp.add(weatherNext[i]);
                      }else {
                        weathersByDay.add(temp.toList());
                        temp.clear();
                        currentWeather = weatherNext[i];
                        temp.add(currentWeather);
                      }
                      if(i == weatherNext.length-1){
                        weathersByDay.add(temp.toList());
                      }
                    }
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
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 10,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none
                            ),
                            child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: GlobalsWidget.positiveGradient
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w).copyWith(bottom: 2.h),
                                child:  Column(
                                  children: [
                                    Align(
                                          alignment: Alignment.center,
                                          child: Text(weather.areaName!, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: GlobalsWidget.fontSizes.bigSize),),
                                        ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Image.network("https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png", fit: BoxFit.fitWidth,alignment: Alignment.centerLeft),
                                        ),
                                        Text("${weather.temperature!.celsius!.round()}°",
                                          style: TextStyle(fontSize: 34.sp, color: Colors.white, fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    SizedBox(height: 1.h,),
                                    Text(toBeginningOfSentenceCase(DateFormat("EEEE, dd MMMM").format(currentDateTime))!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: GlobalsWidget.fontSizes.mainSize),),
                                    SizedBox(height: 2.h,),
                                    Text(toBeginningOfSentenceCase(weather.weatherDescription)!, style: TextStyle(color: GlobalsWidget.gray4, fontSize: GlobalsWidget.fontSizes.smallSize),),
                                    SizedBox(height: 2.h,),
                                    Divider(color: GlobalsWidget.gray2,),
                                    SizedBox(height: 2.h,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/wind.svg"),
                                                  SizedBox(width: 2.w,),
                                                  Text("${weather.windSpeed} м/с", style: TextStyle(color: GlobalsWidget.gray4),)
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/cloud.svg"),
                                                  SizedBox(width: 2.w,),
                                                  Text("${weather.humidity!.round()} %", style: TextStyle(color: GlobalsWidget.gray4),),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 1.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/temp.svg"),
                                                  SizedBox(width: 2.w,),
                                                  Text("${weather.tempMin!.celsius!.round()} \u2103", style: TextStyle(color: GlobalsWidget.gray4),)
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset("assets/drop.svg"),
                                                  SizedBox(width: 2.w,),
                                                  Text("${precipitation.round()} мм", style: TextStyle(color: GlobalsWidget.gray4),),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Text("${S.of(context).event_time_today}, ${DateFormat("dd MMMM").format(currentDateTime)}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: GlobalsWidget.fontSizes.bigSize, color: GlobalsWidget.eventSecondaryText),),
                          SizedBox(height: 2.h,),
                          SizedBox(
                              height: 10.h,
                              child: GridView.count(
                                  crossAxisCount: 6,
                                  primary: false,
                                  childAspectRatio: (15.w / 10.h),
                                  shrinkWrap: true,
                                  children: listWeathers(weatherNext)
                              ),
                          ),
                          SizedBox(height: 1.h,),
                          Text(S.of(context).weather_week,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: GlobalsWidget.fontSizes.mainSize, color: GlobalsWidget.eventSecondaryText),),
                          SizedBox(height: 2.h,),
                          ListView.builder(
                            itemCount: weathersByDay.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index){
                                return Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(toBeginningOfSentenceCase(DateFormat("EEEE").format(weathersByDay[index].first.date!))!,
                                            style: TextStyle(color: GlobalsWidget.gray3, fontSize: GlobalsWidget.fontSizes.mainSize),),
                                            SvgPicture.asset("assets/cloud-fill.svg")
                                          ],
                                        ),
                                        Align(alignment: Alignment.center,child: Text("${weathersByDay[index].first.temperature!.celsius!.round()}°",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: GlobalsWidget.fontSizes.mainSize, color: GlobalsWidget.eventSecondaryText), textAlign: TextAlign.center,),)
                                      ],
                                    ),
                                    SizedBox(height: 2.h,),
                                  ],
                                );
                              }
                          )
                        ],
                      ),
                    );
                  }else{
                    return _loadingWidget();
                  }

                });
              }else{
                return _loadingWidget();
              }
          },)
            ,),
        )
    );
  }
void loadWeatherNext(WeatherFactory wf) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  double long = sharedPreferences.getDouble("latestLONG")!;
  double lat = sharedPreferences.getDouble("latestLAT")!;
  setState(() {
    weatherNext = wf.fiveDayForecastByLocation(lat, long);
  });
}
void loadWeather(WeatherFactory wf) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  double long = sharedPreferences.getDouble("latestLONG")!;
  double lat = sharedPreferences.getDouble("latestLAT")!;
  setState(() {
    weather =  wf.currentWeatherByLocation(lat, long);
  });
}
List<Widget> listWeathers(List<Weather> list){
    List<Widget> list0 = [];
    for(int i = 0; i < 6; i++){
      list0.add(weatherHours(list[i], i));
    }
    return list0;
}
Widget weatherHours(Weather weather, int index){
    return SizedBox(
          height: 10.h,
          width: 15.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(index==0?S.of(context).weather_time_now:DateFormat("HH:mm").format(weather.date!),
              style: TextStyle(fontSize: GlobalsWidget.fontSizes.smallSize, color: GlobalsWidget.gray3),),
              SvgPicture.asset("assets/cloud-fill.svg"),
              Text("${weather.temperature!.celsius!.round()}°", style: TextStyle(fontWeight: FontWeight.bold, color: GlobalsWidget.gray3, ),)
            ],
          )
    );
}
Widget _loadingWidget(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 10,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none
              ),
              child: Container(
                width: double.maxFinite,
                height: 46.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: GlobalsWidget.positiveGradient
                ),
                child: Padding(
                  padding: EdgeInsets.all(25.sp),
                  child:  const Column(
                    children: [

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Text("${S.of(context).event_time_today}, ${DateFormat("dd MMMM").format(DateTime.now())}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: GlobalsWidget.fontSizes.bigSize, color: GlobalsWidget.eventSecondaryText),),
            SizedBox(height: 2.h,),
            Text(S.of(context).weather_week,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: GlobalsWidget.fontSizes.mainSize, color: GlobalsWidget.eventSecondaryText),),
            SizedBox(height: 2.h,),
            Column(
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(toBeginningOfSentenceCase(DateFormat("EEEE").format(DateTime.now()))!,
                          style: TextStyle(color: GlobalsWidget.gray3, fontSize: GlobalsWidget.fontSizes.mainSize),),
                        SvgPicture.asset("assets/cloud-fill.svg")
                      ],
                    ),
                    Align(alignment: Alignment.center,child: Text("0 °",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: GlobalsWidget.fontSizes.smallSize),),)
                  ],
                ),
                SizedBox(height: 2.h,),
              ],
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(toBeginningOfSentenceCase(DateFormat("EEEE").format(DateTime.now()))!,
                          style: TextStyle(color: GlobalsWidget.gray3, fontSize: GlobalsWidget.fontSizes.mainSize),),
                        SvgPicture.asset("assets/cloud-fill.svg")
                      ],
                    ),
                    Align(alignment: Alignment.center,child: Text("0 °",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: GlobalsWidget.fontSizes.smallSize),),)
                  ],
                ),
                SizedBox(height: 2.h,),
              ],
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(toBeginningOfSentenceCase(DateFormat("EEEE").format(DateTime.now()))!,
                          style: TextStyle(color: GlobalsWidget.gray3, fontSize: GlobalsWidget.fontSizes.mainSize),),
                        SvgPicture.asset("assets/cloud-fill.svg")
                      ],
                    ),
                    Align(alignment: Alignment.center,child: Text("0 °",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: GlobalsWidget.fontSizes.smallSize),),)
                  ],
                ),
                SizedBox(height: 2.h,),
              ],
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(toBeginningOfSentenceCase(DateFormat("EEEE").format(DateTime.now()))!,
                          style: TextStyle(color: GlobalsWidget.gray3, fontSize: GlobalsWidget.fontSizes.mainSize),),
                        SvgPicture.asset("assets/cloud-fill.svg")
                      ],
                    ),
                    Align(alignment: Alignment.center,child: Text("0 °",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: GlobalsWidget.fontSizes.smallSize),),)
                  ],
                ),
                SizedBox(height: 2.h,),
              ],
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(toBeginningOfSentenceCase(DateFormat("EEEE").format(DateTime.now()))!,
                          style: TextStyle(color: GlobalsWidget.gray3, fontSize: GlobalsWidget.fontSizes.mainSize),),
                        SvgPicture.asset("assets/cloud-fill.svg")
                      ],
                    ),
                    Align(alignment: Alignment.center,child: Text("0 °",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: GlobalsWidget.fontSizes.smallSize),),)
                  ],
                ),
                SizedBox(height: 2.h,),
              ],
            ),
          ],
        ),
      ),
    );
}
}
