import 'package:app/enums/EventType.dart';
import 'package:app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class FontSizes{
  double get bigSize => 18.sp;
  double get mainSize => 16.sp;
  double get smallSize => 14.sp;
  double get verySmallSize => 12.sp;
}
class GlobalsWidget{
  static Color redColor = const Color(0xffE8232C);
  static Color secondaryText = const Color(0xff6B6B6B);
  static Color eventSecondaryText = const Color(0xff575757);
  static Color gray1 = const Color(0xffF6F6F6);
  static Color gray2 = const Color(0xffE8E8E8);
  static Color gray3 = const Color(0xff9A9A9A);
  static Color gray4 = const Color(0xffD2D3D5);
  static Color gray5 = const Color(0xffA6A6A6);
  static Color gray6 = const Color(0xffBDBDBD);
  static Color positiveColor = const Color(0xff4B9460);
  static Color mediumColor = const Color(0xffFFD808);
  static Color negativeColor = const Color(0xffFF6746);
  static Color weatherColor1 = const Color(0xff60B4F5);
  static Color weatherColor2 = const Color(0xff2E7CC4);
  static Color weatherColor3 = const Color(0xffE8232C);
  static Color weatherColor4 = const Color(0xffBA040C);


  static FontSizes fontSizes = FontSizes();

  static LinearGradient positiveGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        GlobalsWidget.weatherColor1,
        GlobalsWidget.weatherColor2
      ]
  );
  static LinearGradient negativeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        GlobalsWidget.weatherColor3,
        GlobalsWidget.weatherColor4
      ]
  );
  static Widget emptyWidget(){
    return const SizedBox.shrink();
  }

  static Widget eventWidget(String title,EventType type, DateTime time, double value,bool is24){
    DateTime currentTime = DateTime.now();
    int difference = currentTime.difference(time).inHours;
    String time0 = S.current.event_time_hours(difference);
    if(difference>0){
      time0 = S.current.event_time_hours(difference);
    }else{
      difference = currentTime.difference(time).inMinutes;
      time0 = S.current.event_time_minutes(difference);
      if(!(difference>0)){
        difference = currentTime.difference(time).inSeconds;
        time0 = S.current.event_time_seconds(difference);
      }
    }
    return GestureDetector(
        onTap: (){

        },
        child: SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizes.mainSize),),
                      Text(is24?DateFormat("HH:mm").format(time):DateFormat("HH:mm a").format(time), style: TextStyle(color: eventSecondaryText, fontSize: fontSizes.smallSize),),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(EventTypeUtils.eventTypeString(type), style: TextStyle(color: eventSecondaryText,fontSize: fontSizes.smallSize),),
                      Text(time0, style: TextStyle(color: eventSecondaryText, fontSize: fontSizes.smallSize),)
                    ],
                  ),
                ],
              )),
              SizedBox(width: 2.w,),
              Row(
                children: [
                  Text(NumberFormat.decimalPatternDigits(locale: "ru", decimalDigits: 1).format(value), style: TextStyle(color: getColorByValue(value), fontSize: fontSizes.bigSize, fontWeight: FontWeight.bold),),
                  Icon(Icons.arrow_forward_ios_sharp, size: 4.w,)
                ],
              )
            ],
          ),
        ),
      );
  }
 static Color getColorByValue(double value){
    if(value<3){
      return positiveColor;
    }else if(value>3 && value<4.5){
      return mediumColor;
    }else{
      return negativeColor;
    }
  }
  static Widget classicButton(String title, Color color, Function() onClick){
    return SizedBox(
      width: double.maxFinite,
      height: 32.sp,
      child: OutlinedButton(
          onPressed: onClick,
          style: OutlinedButton.styleFrom(
              backgroundColor: color,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),
          child: Text(title, style: const TextStyle(color: Colors.white),)),
    );
  }
  static Widget loadingScreen(){
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: redColor,
          size: 200,
        ),
      ),
    );
  }
}