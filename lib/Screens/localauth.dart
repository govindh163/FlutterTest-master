import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:local_auth/local_auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;
  String _authorizedOrNot = "Not Authorized";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listofBiometrics;
    try {
      listofBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listofBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete your transaction",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'AUth'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Bottom NaviBar"),
            RaisedButton(
              onPressed:() => Navigator.pushNamed(context, "/navi"),
              child: Text("Check Biometric"),
              color: Colors.red,
              colorBrightness: Brightness.light,
            ),
            Text("Can we check Biometric : $_canCheckBiometric"),
            RaisedButton(
              onPressed: _checkBiometric,
              child: Text("Check Biometric"),
              color: Colors.red,
              colorBrightness: Brightness.light,
            ),
            Text("List Of Biometric : ${_availableBiometricTypes.toString()}"),
            RaisedButton(
              onPressed: _getListOfBiometricTypes,
              child: Text("List of Biometric Types"),
              color: Colors.red,
              colorBrightness: Brightness.light,
            ),
            Text("Authorized : $_authorizedOrNot"),
            RaisedButton(
              onPressed: _authorizeNow,
              child: Text("Authorize now"),
              color: Colors.red,
              colorBrightness: Brightness.light,
            ),
          ],
        ),
      ),
    );
  }
}
class CustomIcons {
  CustomIcons._();

  static const _kFontFamily = 'IconFont';

  static const IconData calendar =
  const IconData(0xe800, fontFamily: _kFontFamily);
  static const IconData podcasts =
  const IconData(0xe801, fontFamily: _kFontFamily);
  static const IconData home = const IconData(0xe802, fontFamily: _kFontFamily);
  static const IconData search =
  const IconData(0xe803, fontFamily: _kFontFamily);
  static const IconData tickets =
  const IconData(0xe804, fontFamily: _kFontFamily);
}
class Navibar extends StatefulWidget {
  @override
  _NavibarState createState() => _NavibarState();
}

class _NavibarState extends State<Navibar> {
  int _selectedItemPosition = 2;
  SnakeBarStyle snakeBarStyle = SnakeBarStyle.floating;
  SnakeShape snakeShape = SnakeShape.circle;
  ShapeBorder bottomBarShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)));
  double elevation = 0;
  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color backgroundColor = Colors.white;
  Color selectionColor = Colors.black;

  Gradient backgroundGradient =
  const LinearGradient(colors: [Colors.black, Colors.lightBlue]);
  Gradient selectionGradient =
  const LinearGradient(colors: [Colors.white, Colors.amber]);

  EdgeInsets padding = EdgeInsets.all(12);
  Color containerColor = Color(0xFFFDE1D7);
  TextStyle labelTextStyle = TextStyle(
      fontSize: 11, fontFamily: 'Ubuntu', fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SnakeBottomBar Example')),
      bottomNavigationBar: SnakeNavigationBar(
        style: snakeBarStyle,
        snakeShape: snakeShape,
        snakeColor: selectionColor,
        backgroundColor: backgroundColor,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        shape: bottomBarShape,
        padding: padding,
        currentIndex: _selectedItemPosition,
        onPositionChanged: (index) =>
            setState(() => _selectedItemPosition = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.tickets),
              title: Text('tickets', style: labelTextStyle)),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.calendar),
              title: Text('calendar', style: labelTextStyle)),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.home),
              title: Text('home', style: labelTextStyle)),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.podcasts),
              title: Text('microphone', style: labelTextStyle)),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.search),
              title: Text('search', style: labelTextStyle))
        ],
      ),
    );
  }
}