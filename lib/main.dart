import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/InshortSwipe.dart';
import 'package:flutter_app/Screens/NotePage.dart';
import 'package:flutter_app/Screens/Search.dart';
import 'package:flutter_app/Screens/Texttospeech.dart';
import 'package:flutter_app/Screens/Updatedb.dart';
import 'package:flutter_app/Screens/nativevolume.dart';
import 'package:flutter_app/Screens/ocrtext.dart';
import 'package:flutter_app/Screens/timepicker.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'Screens/AccessContacts.dart';
import 'Screens/Adsflutter.dart';
import 'Screens/Cameraacces.dart';
import 'Screens/Contacts.dart';
import 'Model/appmodel.dart';
import 'Screens/Flipcard.dart';
import 'Screens/GenderPredicter.dart';
import 'Screens/InappBrowser.dart';
import 'Screens/QrScanner.dart';
import 'Screens/Scratchcard.dart';
import 'Screens/Swiper.dart';
import 'Screens/Textanimation.dart';
import 'Screens/Time.dart';
import 'Screens/graphs.dart';
import 'Screens/json.dart';
import 'Screens/localnotification.dart';
import 'Screens/urllauncher.dart';
import 'homepage.dart';
import 'Screens/localauth.dart';
import 'Screens/network.dart';

void main() async {
//  httpLog.enabled = true;

  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _app = AppModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>.value(
      value:_app ,
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'You Are GREAT',
            debugShowCheckedModeBanner: false,
            theme: Provider.of<AppModel>(context).darkTheme
                ? buildDarkTheme()
                .copyWith(primaryColor:Colors.orangeAccent )
                : buildLightTheme()
                .copyWith(primaryColor:Colors.orangeAccent),
            home: Splash(),
            routes:<String, WidgetBuilder> {
              '/land': (context) => LandingPage(),
              '/auth':(context) => MyHomePage(),
              '/json':(context) => MessageList(),
              '/camera':(context) => Homepage(),
              '/graphs':(context) => StatisticsPage(),
              '/browser':(context) => WebViewExample(),
              '/scartch':(context) => AppBody(),
              '/gender':(context) => GenderPredict(),
              '/call':(context) => CallPhone(),
              '/contacts':(context) => ContactListPage(),
              '/add': (BuildContext context) => AddContactPage(),
              '/qrscan': (BuildContext context) => QrScan(),
              '/networkcheck': (BuildContext context) => NetworkCheck(),
              '/swiper': (BuildContext context) => SwiperS(),
              '/localnotify': (BuildContext context) => LocalNotify(),
              '/calendar': (BuildContext context) => Calendar(),
              '/text': (BuildContext context) => TextAnimate(),
              '/urllaunch': (BuildContext context) => WebViewContainer(),
              '/nativevolume': (BuildContext context) => NativeVolume(),
              '/texttospeech': (BuildContext context) => TTSPluginRecipe(),
              '/flipcard': (BuildContext context) => CardFlip(),
              '/time': (BuildContext context) => FlutterTimeDemo(),
              '/admob': (BuildContext context) => AdmobFlutter(),
              '/country': (BuildContext context) => AllCountries(),
              '/dbsql': (BuildContext context) => DBTestPage(),
              '/studentmgmr': (BuildContext context) => UpdatePage(),
              '/ocrtext': (BuildContext context) => BottomBar(),
              '/news': (BuildContext context) => NewsPage(),
            },
          );
        },),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new LandingPage(),
        title: new Text('Welcome to SmartIApps',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("Flutter Egypt"),
        loaderColor: Colors.red
    );
  }
}