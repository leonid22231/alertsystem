// ignore_for_file: file_names

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app/api/RestClient.dart';
import 'package:app/pages/ForumPage.dart';
import 'package:app/pages/HistoryPage.dart';
import 'package:app/pages/MapPage.dart';
import 'package:app/pages/SettingsPage.dart';
import 'package:app/pages/WeatherPage.dart';
import 'package:app/utils/firebase.dart';
import 'package:app/utils/globals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

//ignore: must_be_immutable
class HomePage extends StatefulWidget{
  Position position;
  HomePage({required this.position,super.key});
  @override
  State<StatefulWidget> createState() => _HomePage();
}
class _HomePage extends State<HomePage> with TickerProviderStateMixin{
  int _bottomBarIndex = 4;
  late AnimationController _hideBottomBarAnimationController;
  late AnimationController _fabAnimationController;
  late CurvedAnimation fabCurve;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late AnimationController _borderRadiusAnimationController;
  late CurvedAnimation borderRadiusCurve;
  @override
  void initState() {
    super.initState();
    saveLatestPosition(widget.position);
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    Future.delayed(
      const Duration(seconds: 1),
          () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
          () => _borderRadiusAnimationController.forward(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: GlobalsWidget.redColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        elevation: 5,
        onPressed: () {
          setState(() {
            _bottomBarIndex = 4;
          });
        },
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: GlobalsWidget.positiveGradient
          ),
          child: Center(
            child: SizedBox(
              height: 23.sp,
              width: 23.sp,
              child: SvgPicture.asset("assets/weather.svg", height: 23.sp,width: 23.sp,),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        tabBuilder: (index,isActive){
          return getIcon(index, isActive);
        },
        elevation: 1,
        height: 8.h,
        notchAndCornersAnimation: borderRadiusAnimation,
        activeIndex: _bottomBarIndex,
        gapLocation: GapLocation.center,
        hideAnimationController: _hideBottomBarAnimationController,
        shadow:  BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.black.withOpacity(0.3),
      ),
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => setState(() => _bottomBarIndex = index),
        //other params
      ),
      body: NotificationListener<ScrollNotification>(
      onNotification: onScrollNotification,
      child: getPage(_bottomBarIndex),
    ),
    );
  }
  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }
  Widget getPage(int index){
    switch(index){
      case 0: return const HistoryPage();
      case 1: return const MapPage();
      case 2: return const ForumPage();
      case 3: return const SettingsPage();
      case 4: return const WeatherPage();
      default: return GlobalsWidget.emptyWidget();
    }
  }
  void saveLatestPosition(Position position) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble("latestLONG", position.longitude);
    sharedPreferences.setDouble("latestLAT", position.latitude);

    Dio dio = Dio();
    RestClient client = RestClient(dio);
    client.locationUpdate(FirebaseGlobals.uid, position.latitude, position.longitude);

  }
  Widget getIcon(int index, bool isActive){
    switch(index){
      case 0: return SvgPicture.asset("assets/ep_list.svg",fit: BoxFit.scaleDown, colorFilter: isActive?ColorFilter.mode(GlobalsWidget.redColor, BlendMode.srcATop):null,);
      case 1: return SvgPicture.asset("assets/map.svg",fit: BoxFit.scaleDown, colorFilter: isActive?ColorFilter.mode(GlobalsWidget.redColor, BlendMode.srcATop):null);
      case 2: return SvgPicture.asset("assets/chat.svg",fit: BoxFit.scaleDown, colorFilter: isActive?ColorFilter.mode(GlobalsWidget.redColor, BlendMode.srcATop):null);
      case 3: return SvgPicture.asset("assets/settings.svg",fit: BoxFit.scaleDown, colorFilter: isActive?ColorFilter.mode(GlobalsWidget.redColor, BlendMode.srcATop):null);
      default: SvgPicture.asset("assets/ep_list.svg", height: 15.sp, width: 20.sp,);
    }
    return SvgPicture.asset("assets/ep_list.svg", height: 15.sp, width: 20.sp,);
  }
}