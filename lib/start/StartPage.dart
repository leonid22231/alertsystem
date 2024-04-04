// ignore_for_file: file_names

import 'package:app/generated/l10n.dart';
import 'package:app/utils/globals.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class StartPage extends StatefulWidget{
  const StartPage({super.key});

  @override
  State<StatefulWidget> createState() => _StartPage();

}
class _StartPage extends State<StartPage>{
  int step = 0;

  @override
  Widget build(BuildContext context) {
     return PopScope(
       canPop: !(step>0),
       onPopInvoked: (value){
          setState(() {
            step--;
          });
       },
       child: Scaffold(
       body: Padding(
         padding: EdgeInsets.all(16.sp),
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SvgPicture.asset("assets/icon.svg", height: 50.sp, width: 50.sp,),
               SizedBox(height: 30.sp,),
               Text(_getTitleByStep(step), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
               _getStep(step),
               SizedBox(height: 20.sp,),
               SizedBox(
                 height: 30.h,
                 child: Column(
                   children: [
                     AnimatedSwitcher(
                       duration: const Duration(milliseconds: 350),
                      transitionBuilder: (_,__){
                        return ScaleTransition(scale: __, child: _);
                      },
                       child: _getTextByStep(step),),
                     _getNextStep(step)
                   ],
                 ),
               ),
               SizedBox(height: 20.sp,),
               GlobalsWidget.classicButton(step!=3?S.of(context).button_next:S.of(context).button_end, GlobalsWidget.redColor, () async {
                 switch(step){
                   case 0: {
                     setState(() {
                       step++;
                     });
                   }
                   case 1:{
                     var status = await Permission.location.status;
                     if(status.isDenied){
                       if(await Permission.location.request().isGranted){
                         setState(() {
                           step++;
                         });
                       }
                     }else if(status.isGranted){
                       setState(() {
                         step++;
                       });
                     }
                   }
                   case 2:
                     {
                       var status = await Permission.notification.status;
                       if (status.isDenied) {
                          if(await Permission.notification.request().isGranted){
                              setState(() {
                                step++;
                              });
                          }
                       }else{
                         setState(() {
                           step++;
                         });
                       }
                     }
                   case 3:{
                     SharedPreferences pref = await SharedPreferences.getInstance();
                     pref.setBool("welcome", false);
                     // ignore: use_build_context_synchronously
                     NotifyEndWelcome().dispatch(context);
                   }
                 }
               }),
             ],
           ),
         ),
       ),
     ),
     );
  }
  Widget _getNextStep(int step){
    if(step==0){
      return Column(
        children: [
          SizedBox(height: 25.sp,),
          Text(S.of(context).welcome_text_next, style: TextStyle(fontSize: 16.sp, color: GlobalsWidget.secondaryText),)
        ],
      );
    }else{
      return GlobalsWidget.emptyWidget();
    }
  }
  Widget _getTextByStep(int step){
    switch(step){
      case 0: return RichText(
        key: ValueKey(step),
        textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: S.of(context).welcome_text_0,
                style: TextStyle(color: GlobalsWidget.secondaryText, fontSize: 16.sp),
              ),
              TextSpan(
                text: S.of(context).welcome_text_0_0,
                style: TextStyle(color: GlobalsWidget.redColor, fontSize: 16.sp, decorationColor: GlobalsWidget.redColor, decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () { launchUrl(Uri.parse('https://docs.flutter.io/flutter/services/UrlLauncher-class.html'));
                  },
              ),
            ]
          )
      );
      case 1: return Text(key: ValueKey(step),S.of(context).welcome_text_1, style: TextStyle(color: GlobalsWidget.secondaryText, fontSize: 16.sp),textAlign: TextAlign.center,);
      case 2: return Text(key: ValueKey(step),S.of(context).welcome_text_2, style: TextStyle(color: GlobalsWidget.secondaryText, fontSize: 16.sp),textAlign: TextAlign.center,);
      case 3: return Text(key: ValueKey(step),S.of(context).welcome_text_3,style: TextStyle(color: GlobalsWidget.secondaryText, fontSize: 16.sp),textAlign: TextAlign.center,);
      default: return GlobalsWidget.emptyWidget();
    }
  }
  Widget _getStep(int step){
    if(step==0 || step==3){
      return GlobalsWidget.emptyWidget();
    }else{
      return Column(
        children: [
          SizedBox(height: 10.sp,),
          Text(S.of(context).welcome_step(step), style: TextStyle(color: GlobalsWidget.secondaryText, fontSize: 17.sp, fontWeight: FontWeight.bold),),
          SizedBox(height: 10.sp,),
        ],
      );
    }
  }
  String _getTitleByStep(int step){
     switch(step){
       case 0:return S.of(context).welcome_title_0;
       case 1:return S.of(context).welcome_title_1;
       case 2:return S.of(context).welcome_title_2;
       case 3:return S.of(context).welcome_title_3;
       default:return "";
     }
  }
}
class NotifyEndWelcome extends Notification{
  NotifyEndWelcome();
}