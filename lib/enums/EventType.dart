// ignore_for_file: file_names, constant_identifier_names

import 'package:app/generated/l10n.dart';
import 'package:flutter_svg/svg.dart';

enum EventType{
  EARTHQUAKE,
  FIRE,
  LANDSLIDE,
  FLOODS,
  SEL,
  AVALANCHE;
}
class EventTypeUtils{
  static String eventTypeString(EventType type){
    switch(type){
      case EventType.EARTHQUAKE: return S.current.event_type_1;
      case EventType.FIRE: return S.current.event_type_2;
      case EventType.LANDSLIDE: return S.current.event_type_3;
      case EventType.FLOODS: return S.current.event_type_4;
      case EventType.SEL: return S.current.event_type_5;
      case EventType.AVALANCHE: return S.current.event_type_6;
    }
  }
  static SvgPicture eventTypeIcon(EventType type){
    switch(type){
      case EventType.EARTHQUAKE: return SvgPicture.asset("assets/earthquake.svg");
      case EventType.FIRE: return  SvgPicture.asset("assets/fire.svg");
      case EventType.LANDSLIDE: return SvgPicture.asset("assets/landslide.svg");
      case EventType.FLOODS: return SvgPicture.asset("assets/landslide_2.svg");
      case EventType.SEL: return SvgPicture.asset("assets/landslide_1.svg");
      case EventType.AVALANCHE: return SvgPicture.asset("assets/avalanche.svg");
    }
  }
  static EventType eventTypeByInt(int type){
    switch(type){
      case 0: return EventType.EARTHQUAKE;
      case 1: return EventType.FIRE;
      case 2: return EventType.LANDSLIDE;
      case 3: return EventType.FLOODS;
      case 4: return EventType.SEL;
      case 5: return EventType.AVALANCHE;
    }
    return EventType.EARTHQUAKE;
  }
}