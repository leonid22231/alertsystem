
import 'package:app/api/RestClient.dart';
import 'package:app/entitis/ForumEntity.dart';
import 'package:app/entitis/MessageEntity.dart';
import 'package:app/entitis/UserEntity.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/utils/firebase.dart';
import 'package:app/utils/globals.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatPage extends StatefulWidget{
  final ForumEntity forumEntity;

  const ChatPage({required this.forumEntity, super.key});

  @override
  State<StatefulWidget> createState() => _ChatPage();
}
class _ChatPage extends State<ChatPage>{
  Future<List<MessageEntity>> messages = Future.value([]);
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  late Socket socket;
  @override
  void initState() {
    super.initState();
    getMessages();
    connectToServer();
  }
  @override
  void dispose() {
    disconnectFromServer();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    ForumEntity forum = widget.forumEntity;
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(forum.name, style: TextStyle(fontSize: GlobalsWidget.fontSizes.bigSize, fontWeight: FontWeight.bold),),
          centerTitle: true,
          leadingWidth: 25.w,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 2.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-t74Z8p7O8AKwt_xS5mGvgVpQZG0-NSVfYVukFVTU0A&s",
                  height: 5.h,
                  width: 4.5.h,
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
          leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).button_back,textAlign: TextAlign.center, style: TextStyle(fontSize: GlobalsWidget.fontSizes.mainSize,fontWeight: FontWeight.bold, color: GlobalsWidget.redColor),)
              ],
            ),
          ),
        ),
      body: Padding(
        padding: EdgeInsets.all(1.h).copyWith(bottom: 3.h),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: FutureBuilder(
                future: messages,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_){
                      if (_scrollController.hasClients) {
                        _scrollController.jumpTo(0);
                      }
                    });
                    return SizedBox(
                      width: double.maxFinite,
                      child: ListView(
                        reverse: true,
                        controller: _scrollController,
                        children: snapshot.data!.reversed.map((e) => ChatBubble(
                          clipper: ChatBubbleClipper1(type: _bubbleType(e.user)),
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor:_bubbleType(e.user)==BubbleType.sendBubble?GlobalsWidget.redColor:GlobalsWidget.gray2,
                          alignment: _bubbleType(e.user)==BubbleType.sendBubble?Alignment.topRight:null,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 70.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.user==null?forum.name:e.user!.user_name,
                                  style: TextStyle(color: _bubbleType(e.user)==BubbleType.sendBubble?Colors.white:Colors.black),
                                ),
                                Text(
                                  e.content,
                                  style: TextStyle(color: _bubbleType(e.user)==BubbleType.sendBubble?Colors.white:Colors.black),
                                )
                              ],
                            ),
                          ),
                        )).toList(),
                      ),
                    );

                  }else{
                    print(snapshot.error);
                    return Center(
                      child: Text("Загрузка..."),
                    );
                  }
                },
              )),
              SizedBox(height: 2.h,),
              SizedBox(
                height: 6.h,
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    fillColor: GlobalsWidget.gray1,
                      filled: true,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 1.h),
                        child: InkWell(
                          onTap: (){
                            if(_textEditingController.value.text.isNotEmpty && _textEditingController.value.text.replaceAll(" ", "").isNotEmpty){
                              sendMessage();
                            }
                          },
                          child: Container(
                            height: 5.h,
                            width: 5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: GlobalsWidget.redColor
                            ),
                            child: Center(
                              child: Icon(Icons.arrow_upward_outlined, color: Colors.white,),
                            ),
                          ),
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(

                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 1.5.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: GlobalsWidget.gray2
                          )
                      ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: GlobalsWidget.gray2
                        )
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  BubbleType _bubbleType(UserEntity? userEntity){
    if(userEntity==null){
      return BubbleType.receiverBubble;
    }else{
      if(userEntity.user_uid==FirebaseGlobals.uid){
        return BubbleType.sendBubble;
      }else{
        return BubbleType.receiverBubble;
      }
    }
  }
  void _scrollDown() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
void getMessages(){
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    messages = client.getForum(widget.forumEntity.id);
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
  void connectToServer() {
    try {
      print("Connect to room ${widget.forumEntity.id}");
      OptionBuilder optionBuilder = OptionBuilder();
      Map<String, dynamic> opt = optionBuilder
          .disableAutoConnect()
          .setTransports(["websocket"])
          .setQuery({
        "room": widget.forumEntity.id,
        "uid": FirebaseGlobals.uid
      }).build();
      opt.addAll({
        "forceNew": true
      });
      socket = io('http://192.168.0.25:8081', opt);
      socket.connect();
      socket.on('connect', (_){
        debugPrint("Connect");
      });
      socket.on('disconnect', (_){
        debugPrint("Disconnect");
      });
      socket.on("read_message", (data) async {
          getMessages();
          setState(() {

          });
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  Future<void> sendMessage() async {
      print("Send");
      socket.emit("send_message", {
        "content":_textEditingController.value.text
      });
      _textEditingController.clear();
      getMessages();
      setState(() {

      });
  }
}