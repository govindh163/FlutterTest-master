import 'dart:async';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'Model/appmodel.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  ScrollController _scrollController = new ScrollController();
  @override
  String _connectionStatus = 'Unknown';
  bool connected=false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }
    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() {
          connected = true;
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          connected = true;
          return _connectionStatus = result.toString();
        });
        break;
      case ConnectivityResult.none:
        Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: 'Seems Not Connected To Internet',
          textColor: Colors.redAccent,
        );
        setState(() {
          connected = false;
          return _connectionStatus = result.toString();
        });
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Click the Drawer"),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 50.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: connected
                  ? Image.network(
                  'https://images.unsplash.com/photo-1562887245-9d941e87344e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80')
                  : Container(
                child: Center(
                  child: Text(
                    "Please Connect to Internet",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: connected
                  ? Image.network(
                  'https://images.unsplash.com/photo-1570712884211-24c5bd3bf0b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
                  : null,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: connected
                  ? Image.network(
                  'https://images.unsplash.com/photo-1569326513740-fd376db73ad5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
                  : null,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: connected
                  ? Image.network(
                  'https://images.unsplash.com/photo-1568381908900-4d012e82082b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
                  : null,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: connected
                  ? Image.network(
                  'https://images.unsplash.com/photo-1556695725-1275cb8083c5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60')
                  : null,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  children: <Widget>[
                    Image.network(
                        'https://images.pexels.com/photos/2150/sky-space-dark-galaxy.jpg?cs=srgb&dl=astronomy-black-wallpaper-constellation-2150.jpg&fm=jpg'),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(
                          Icons.fingerprint,
                          size: 20,
                          color: Colors.green,
                        ),
                        title: Text('Check BIO metrics'),
                        onTap: () => Navigator.pushNamed(context, "/auth")),
                    ListTile(
                        leading: Icon(Icons.rotate_90_degrees_ccw,
                            size: 20, color: Colors.redAccent),
                        title: Text(
                          'Pass Json from remote web',
                          maxLines: 2,
                        ),
                        onTap: () => Navigator.pushNamed(context, "/json")),
                    ListTile(
                        leading: Icon(Icons.camera_alt,
                            size: 20, color: Colors.blueAccent),
                        title: Text('Camera Access'),
                        onTap: () => Navigator.pushNamed(context, "/camera")),
                    ListTile(
                        leading:
                        Icon(Icons.equalizer, size: 20, color: Colors.pink),
                        title: Text('Graphs'),
                        onTap: () => Navigator.pushNamed(context, "/graphs")),
                    ListTile(
                        leading: Icon(Icons.open_in_browser,
                            size: 20, color: Colors.brown),
                        title: Text('In-App Browser'),
                        onTap: () => Navigator.pushNamed(context, "/browser")),
                    ListTile(
                        leading:
                        Icon(Icons.scanner, size: 20, color: Colors.orange),
                        title: Text('G-Pay'),
                        onTap: () {
                          Fluttertoast.showToast(
                            msg: 'Your Earned Card',
                          );
                          Navigator.pushNamed(context, "/scartch");
                        }),
                    ListTile(
                        leading:
                        Icon(Icons.face, size: 20, color: Colors.black),
                        title: Text('Gender'),
                        onTap: () => Navigator.pushNamed(context, "/gender")),
                    ListTile(
                        leading: Icon(Icons.phone_forwarded,
                            size: 20, color: Colors.green),
                        title: Text('Call'),
                        onTap: () => Navigator.pushNamed(context, "/call")),
                    ListTile(
                        leading: Icon(Icons.contacts,
                            size: 20, color: Colors.purple),
                        title: Text('Contacts'),
                        onTap: () => Navigator.pushNamed(context, "/contacts")),
                    ListTile(
                        leading: Icon(Icons.center_focus_weak,
                            size: 20, color: Colors.deepOrange),
                        title: Text('QR Scanner'),
                        onTap: () => Navigator.pushNamed(context, "/qrscan")),
                    ListTile(
                        leading: Icon(Icons.network_check,
                            size: 20, color: Colors.amber),
                        title: Text('Network'),
                        onTap: () =>
                            Navigator.pushNamed(context, "/networkcheck")),
                    ListTile(
                        leading: Icon(Icons.swap_vert,
                            size: 20, color: Colors.indigoAccent),
                        title: Text('Swiper'),
                        onTap: () => Navigator.pushNamed(context, "/swiper")),
                    ListTile(
                        leading: Icon(Icons.notifications_active,
                            size: 20, color: Color(0XFF00bcd4)),
                        title: Text('Get Notification'),
                        onTap: () =>
                            Navigator.pushNamed(context, "/localnotify")),
                    ListTile(
                        leading:
                        Icon(Icons.gif, size: 40, color: Color(0XFF512da8)),
                        title: Text('Giffy Dialog'),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => NetworkGiffyDialog(
                                image: Image.network(
                                    'https://raw.githubusercontent.com/appwise-labs/NoInternetDialog/master/Images/niam.gif'),
                                title: Text(
                                  'Please Connect to Internet',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                description: Text(
                                  'And Enjoy Your Day',
                                  style: TextStyle(),
                                ),
                                entryAnimation: EntryAnimation.LEFT_RIGHT,
                                onOkButtonPressed: () {
                                  Navigator.pop(context);
                                },
                              ));
                        }),
                    Card(
                      margin: EdgeInsets.only(bottom: 2.0),
                      elevation: 0,
                      child: SwitchListTile(
                        secondary: Icon(
                          Icons.dashboard,
                          color: Theme.of(context).accentColor,
                          size: 24,
                        ),
                        value: Provider.of<AppModel>(context).darkTheme,
                        activeColor: Colors.orangeAccent,
                        onChanged: (bool value) {
                          if (value) {
                            Provider.of<AppModel>(context).updateTheme(true);
                          } else
                            Provider.of<AppModel>(context).updateTheme(false);
                        },
                        title: Text(
                          'Dark Theme',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    ListTile(
                        leading: Icon(Icons.date_range,
                          size: 20,  color: Color(0XFF2e7d32),),
                        title: Text('Calendar'),
                        onTap: () =>
                            Navigator.pushNamed(context, "/calendar")),
                    ListTile(
                        leading: Icon(Icons.text_format,
                          size: 20,  color: Color(0XFF9e7e42),),
                        title: Text('Animate Text'),
                        onTap: () =>
                            Navigator.pushNamed(context, "/text")),
                    ListTile(
                        leading: Icon(Icons.text_format,
                          size: 20,  color: Color(0XFF9e7e42),),
                        title: Text('Volume Control'),
                        onTap: () =>
                            Navigator.pushNamed(context, "/nativevolume")),
                    ListTile(
                      leading: Icon(Icons.exit_to_app, size: 20),
                      title: Text('Log Out'),
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}