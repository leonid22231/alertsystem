// ignore_for_file: file_names

import 'package:app/api/RestClient.dart';
import 'package:app/entitis/ForumEntity.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/pages/ChatPage.dart';
import 'package:app/utils/firebase.dart';
import 'package:app/utils/globals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForumPage extends StatefulWidget{
  const ForumPage({super.key});

  @override
  State<StatefulWidget> createState() => _ForumPage();

}
enum Segment {
  forum,
  news,
}
extension SegmentsExtension on Segment {
  String get label {
    switch (this) {
      case Segment.forum:
        return 'forum';
      case Segment.news:
        return 'news';
      default:
        return 'Unrecognized';
    }
  }

  bool get isForum => this == Segment.forum;

  bool get isNews => this == Segment.news;
}
class _ForumPage extends State<ForumPage>{
  final select = ValueNotifier(Segment.forum);
  Segment currentSegment = Segment.forum;
  @override
  void initState() {
    super.initState();
    select.addListener(() {
      setState(() {
          currentSegment = select.value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
      return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(3.h),
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: 5.h,
                    child: AdvancedSegment(
                      backgroundColor: GlobalsWidget.gray2,
                      activeStyle: TextStyle(fontSize: 16.sp, color: GlobalsWidget.redColor, fontWeight: FontWeight.w600),
                      controller: select, // AdvancedSegmentController
                      segments: { // Map<String, String>
                        Segment.forum: S.of(context).forum_f,
                        Segment.news: S.of(context).forum_n,
                      },),
                  ),
                  SizedBox(height: 2.h,),
                  Expanded(child: SingleChildScrollView(
                    child: _getWidget(currentSegment),
                  )
                  )
                ],
              ),
            ),
          )
      );
  }
Future<List<ForumEntity>> getForums() async {
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    return client.getForums(FirebaseGlobals.uid);
}
Widget _getWidget(Segment segment){
    switch(segment){
      case Segment.forum: return forums();
      case Segment.news: return news();
    }
}
Widget forums(){
    return FutureBuilder(
        future: getForums(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<ForumEntity> list = snapshot.data!;
            return ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context,index){
                return _forum(list[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 2.h, thickness: 2,color: GlobalsWidget.gray2,);
              }, itemCount: list.length,
            );
          }else{
            print(snapshot.error);
            return Center(child: Text("Загрузка..."),);
          }
        });
}
Widget _forum(ForumEntity forum){
    DateTime now = DateTime.now();
    return InkWell(
      onTap: (){
        print("Forum id ${forum.id}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage(forumEntity: forum)),
        ).then((value){
          setState(() {

          });
        });
      },
      child: Container(
        height: 8.h,
        width: double.maxFinite,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-t74Z8p7O8AKwt_xS5mGvgVpQZG0-NSVfYVukFVTU0A&s",
                height: 8.h,
                width: 6.h,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 2.w,),
            Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(forum.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
                        Text(forum.lastMessage==null?"":_getDifference(now.difference(forum.lastMessage!.sentTime), context), style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold, color: GlobalsWidget.gray6),)
                      ],
                    ),
                    forum.lastMessage!=null?Text("${_getUser(forum)}: ${forum.lastMessage!.content}",maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: GlobalsWidget.gray3),):Text(S.of(context).forum_message_not_found, style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: GlobalsWidget.gray3),)
                  ],
                ))
          ],
        ),
      ),
    );
}
String _getDifference(Duration duration, BuildContext context){
    if(duration.inSeconds>60){
      return "${duration.inMinutes} ${S.of(context).forum_message_minute_ago}";
    }else if(duration.inMinutes>60){
      return "${duration.inHours} ${S.of(context).forum_message_hour_ago}";
    }else if(duration.inHours>24){
      return "${duration.inDays} ${S.of(context).forum_message_day_ago}";
    }else{
      return "${duration.inSeconds} ${S.of(context).forum_message_second_ago}";
    }
}
String _getUser(ForumEntity forum){
    if(forum.lastMessage!.user==null){
      return forum.name;
    }else{
      return forum.lastMessage!.user!.user_name;
    }
}
Widget news(){
    return Center(child: Text("news"),);
}
}