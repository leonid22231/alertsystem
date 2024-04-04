import 'package:app/api/RestClient.dart';
import 'package:app/firebase_options.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/home/HomePage.dart';
import 'package:app/start/StartPage.dart';
import 'package:app/utils/firebase.dart';
import 'package:app/utils/globals.dart';
import 'package:app/utils/settings.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  if(FirebaseAuth.instance.currentUser == null){
    debugPrint("Auth no. Creating user");
    FirebaseAuth.instance.signInAnonymously().then((value){
      String uid = value.user!.uid;
      messaging.getToken().then((token){
        debugPrint("User uid $uid & token $token");
        FirebaseGlobals.uid = uid;
        Dio dio = Dio();
        RestClient client = RestClient(dio);
        client.register(uid, token!);
      });
    });
  }else{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    debugPrint("Auth yes $uid");
    FirebaseGlobals.uid = uid;
    FirebaseMessaging.instance.getToken().then((token){
      Dio dio = Dio();
      RestClient client = RestClient(dio);
      client.update(uid, token!);
    });
  }

  await GlobalsSettings.loadGlobalsSettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (_,__,___){
      return MaterialApp(
        title: 'Jarshy',
        localizationsDelegates:const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales:  const [
          Locale("ru"),
        ],
        locale: const Locale("ru"),
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
          scaffoldBackgroundColor: const Color(0xfffffffb),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffE8232C)),
          useMaterial3: true,
        ),
        home: const Main(),
      );
    });
  }
}

class Main extends StatefulWidget {
  const Main({super.key});
  @override
  State<Main> createState() => _Main();
}

class _Main extends State<Main> {
  @override
  Widget build(BuildContext context) {
      return FutureBuilder(future: _FPrefs(), builder: (context,snapshot){
        if(snapshot.hasData){
            bool? welcome = snapshot.data!.getBool("welcome");
            if(welcome==null || welcome){
              return NotificationListener<NotifyEndWelcome>(
                onNotification: (m){
                  setState(() {

                  });
                  return true;
                },
                  child: const StartPage()
              );
            }else{
              return FutureBuilder(
                  future: _currentPosition(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return HomePage(position: snapshot.data!);
                    }else{
                      return GlobalsWidget.loadingScreen();
                    }
                  });
            }
        }else{
          return GlobalsWidget.loadingScreen();
        }
      });
  }
  Future<Position> _currentPosition(){
    return Geolocator.getCurrentPosition();
  }
  // ignore: non_constant_identifier_names
  Future<SharedPreferences> _FPrefs(){
    return SharedPreferences.getInstance();
  }
}
