// ignore_for_file: file_names

import 'dart:async';

import 'package:app/api/RestClient.dart';
import 'package:app/entitis/EventEntity.dart';
import 'package:app/entitis/EventEntitySocket.dart';
import 'package:app/enums/EventType.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/utils/firebase.dart';
import 'package:app/utils/globals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget{
  const MapPage({super.key});
  @override
  State<StatefulWidget> createState() => _MapPage();
}
class _MapPage extends State<MapPage>{
  final mapControllerCompleter = Completer<YandexMapController>();
  late FocusNode searchFocus;
  List<MapObject> listMapObjects = [];
  MapType currentType = MapType.map;
  List<bool> selectedEventType = EventType.values.map((e) => true).toList();
  late Socket socket;
  @override
  void initState() {
    super.initState();
    searchFocus = FocusNode();
    getCurrentPositionFromLocal();
    _fetchCurrentLocation().ignore();
    _getActive();
    connectToServer();
  }
  @override
  void dispose() {
    disconnectFromServer();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YandexMap(
          mapType: currentType,
          onMapCreated: (controller) {
            mapControllerCompleter.complete(controller);
          },
          mapObjects: listMapObjects,
        ),
        SafeArea(
            child: Padding(
              padding: EdgeInsets.all(17.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    focusNode: searchFocus,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: GlobalsWidget.gray1,
                      hintText: S.of(context).history_input,
                      hintStyle: TextStyle(color: GlobalsWidget.gray3, fontSize: 16.sp),
                      prefixIcon: Icon(Icons.search, color: GlobalsWidget.gray3, size: 18.sp,),
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
                  SizedBox(height: 10.h,),
                  Card(
                    elevation: 10,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    ),
                    child: Container(
                      width: 10.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: GlobalsWidget.gray1,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            SizedBox(
                              height: 5.h,
                              child: IconButton(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.zero,
                                  onPressed: (){

                                  },
                                  icon: Icon(Icons.help, color: GlobalsWidget.gray5,)),
                            ),
                          SizedBox(
                            height: 5.h,
                            child: IconButton(
                                alignment: Alignment.center,
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  getCurrentPositionFromLocal();
                                },
                                icon: SvgPicture.asset("assets/navigation.svg")),
                          ),
                          SizedBox(
                            height: 5.h,
                            child: IconButton(
                                alignment: Alignment.center,
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  searchFocus.requestFocus();
                                },
                                icon: Icon(Icons.search, color: GlobalsWidget.gray5,)),
                          ),
                          SizedBox(
                            height: 5.h,
                            child: IconButton(
                                alignment: Alignment.center,
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  _zoomPlus();
                                },
                                icon: Icon(Icons.add, color: GlobalsWidget.gray5,)),
                          ),
                          SizedBox(
                            height: 5.h,
                            child: IconButton(
                                alignment: Alignment.center,
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  _zoomMinus();
                                },
                                icon: Icon(Icons.remove, color: GlobalsWidget.gray5,)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }
  void _settingsButton(){
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState){
        return SizedBox(
          height: 70.h,
          child: Padding(
            padding: EdgeInsets.all(18.sp).copyWith(top: 25.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).sort, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                SizedBox(height: 5.h,),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          setState((){
                            selectedEventType[index] = !selectedEventType[index];
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                EventTypeUtils.eventTypeIcon(EventType.values[index]),
                                SizedBox(width: 5.w,)
                              ],
                            ),
                            Flexible(fit: FlexFit.tight, child: Text(EventTypeUtils.eventTypeString(EventType.values[index]), textAlign: TextAlign.start,)),
                            Icon(Icons.warning, color: selectedEventType[index]?GlobalsWidget.negativeColor:GlobalsWidget.gray5,)
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index){
                      return SizedBox(height: 5.h,);
                    }, itemCount: EventType.values.length)
              ],
            ),
          ),
        );
      }),
    );
  }
  Future<void> _fetchCurrentLocation() async {
    Position pos = await Geolocator.getCurrentPosition();
    _moveToCurrentLocation(pos.latitude,pos.longitude);
  }
  Future<void> getCurrentPositionFromLocal() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    double lat = shared.getDouble("latestLAT")!;
    double long = shared.getDouble("latestLONG")!;
    _moveToCurrentLocation(lat, long);
  }
  Future<void> _zoomPlus() async {
    YandexMapController mapController = (await mapControllerCompleter.future);
    CameraPosition currentPosition = (await mapController.getCameraPosition());
    mapController.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 2),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: currentPosition.target.latitude,
            longitude: currentPosition.target.longitude,
          ),
          zoom: currentPosition.zoom+1,
        ),
      ),
    );
  }
  Future<void> _zoomMinus() async {
    YandexMapController mapController = (await mapControllerCompleter.future);
    CameraPosition currentPosition = (await mapController.getCameraPosition());
    mapController.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 2),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: currentPosition.target.latitude,
            longitude: currentPosition.target.longitude,
          ),
          zoom: currentPosition.zoom-1,
        ),
      ),
    );
  }
  BitmapDescriptor _getImage(EventType type){
    switch(type){
      case EventType.EARTHQUAKE: return BitmapDescriptor.fromAssetImage('assets/earthquake.png');
      case EventType.FIRE: return BitmapDescriptor.fromAssetImage('assets/fire.png');
      case EventType.LANDSLIDE: return BitmapDescriptor.fromAssetImage('assets/landslide.png');
      case EventType.FLOODS: return BitmapDescriptor.fromAssetImage('assets/landslide_1.png');
      case EventType.SEL: return BitmapDescriptor.fromAssetImage('assets/landslide_2.png');
      case EventType.AVALANCHE: return BitmapDescriptor.fromAssetImage('assets/avalanche.png');
      default:return BitmapDescriptor.fromAssetImage('assets/user.png');
    }
  }
  void connectToServer() {
    try {
      print("Connect to room events");
      OptionBuilder optionBuilder = OptionBuilder();
      Map<String, dynamic> opt = optionBuilder
          .disableAutoConnect()
          .setTransports(["websocket"])
          .setQuery({
        "room": "events",
        "uid": FirebaseGlobals.uid
      }).build();
      opt.addAll({
        "forceNew": true
      });
      socket = io('http://192.168.0.11:8081', opt);
      socket.connect();
      socket.on('connect', (_){
        debugPrint("Connect");
      });
      socket.on('disconnect', (_){
        debugPrint("Disconnect");
      });
      socket.on("online_events", (data) async {
        EventEntitySocket entity = EventEntitySocket.fromJson(data);
        _addEvent(entity.toEventEntity());
        _moveToLocation(entity.latitude, entity.longitude);
        setState(() {

        });
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void disconnectFromServer(){
    if(socket.active){
      socket.off('connect');
      socket.off('disconnect');
      socket.off('read_message');
      socket.disconnect();
      socket.dispose();
      socket.close();
    }else{
      socket.off('connect');
      socket.off('disconnect');
      socket.off('read_message');
      socket.dispose();
      socket.close();
    }

  }
  void _addEvent(EventEntity e){
    listMapObjects.add(
        ClusterizedPlacemarkCollection(
          mapId: MapObjectId("${e.id}"),
          placemarks: [
            PlacemarkMapObject(
                mapId: MapObjectId("placemark_${e.id}"),
                point: Point(
                    latitude: e.latitude,
                    longitude: e.longitude
                ),
                icon: PlacemarkIcon.single(PlacemarkIconStyle(
                    image: _getImage(e.type),
                    scale: 3,
                  isFlat: true
                ))
            )
          ],
          radius: 10,
          minZoom: 12,
        )
    );
  }
  Future<void> _getActive() async {
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    List<EventEntity> list = await client.getEvents();
    print("Size active ${list.length}");
    list.map((e){
      _addEvent(e);
    }).toList();
    setState(() {

    });
    print("Current size ${listMapObjects.length}");
  }
  Future<void> _moveToLocation(double lat,double long) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: lat,
            longitude: long,
          ),
          zoom: 17,
        ),
      ),
    );
  }
  Future<void> _moveToCurrentLocation(double lat,double long,) async {
    _moveToLocation(lat, long);
    setState(() {
      listMapObjects.add(
            ClusterizedPlacemarkCollection(
              mapId: const MapObjectId("user"),
              placemarks: [
                PlacemarkMapObject(
                    mapId: const MapObjectId("placemark_user"),
                    point: Point(
                  latitude: lat,
                  longitude: long
                ),
                    icon: PlacemarkIcon.single(PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage('assets/user.png'),
                        scale: 1
                    ))
                )
              ],
              radius: 10,
              minZoom: 12,
            )
      );
    });
  }
}