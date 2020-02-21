import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_app/Model/appmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:provider/provider.dart';

class CustomGuitarDrawer extends StatefulWidget {
  final Widget child;

  const CustomGuitarDrawer({Key key, this.child}) : super(key: key);

  static CustomGuitarDrawerState of(BuildContext context) =>
      context.findAncestorStateOfType<CustomGuitarDrawerState>();

  @override
  CustomGuitarDrawerState createState() => new CustomGuitarDrawerState();
}

class CustomGuitarDrawerState extends State<CustomGuitarDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool _canBeDragged = false;
  final double maxSlide = 300.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.translucent,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Material(
            color: Colors.blueGrey,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(maxSlide * (animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: MyDrawer(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: widget.child,
                  ),
                ),
                Positioned(
                  top: 4.0 + MediaQuery.of(context).padding.top,
                  left: 4.0 + animationController.value * maxSlide,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: toggle,
                    color: Colors.white,
                  ),
                ),
//                Positioned(
//                  top: 16.0 + MediaQuery.of(context).padding.top,
//                  left: animationController.value *
//                      MediaQuery.of(context).size.width,
//                  width: MediaQuery.of(context).size.width,
//                  child: Text(
//                    'Hello Flutter Europe',
//                    style: Theme.of(context).primaryTextTheme.title,
//                    textAlign: TextAlign.center,
//                  ),
//                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }
}

class MyDrawer extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                      leading: Icon(Icons.add,
                          size: 20, color: Colors.lightBlueAccent),
                      title: Text(
                        'Give Tips',
                        maxLines: 2,
                      ),
                      onTap: () => Navigator.pushNamed(context, "/tips")),
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
                      leading: Icon(FontAwesomeIcons.robot,
                          size: 20, color: Colors.blueGrey),
                      title: Text('AI Mode'),
                      onTap: () => Navigator.pushNamed(context, "/tflite")),
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
                      leading: Icon(Icons.android,
                          size: 20, color: Colors.green),
                      title: Text('Animate'),
                      onTap: () => Navigator.pushNamed(context, "/animate")),
                  ListTile(
                      leading: Icon(Icons.notifications_active,
                          size: 20, color: Color(0XFF00bcd4)),
                      title: Text('Get Notification'),
                      onTap: () =>
                          Navigator.pushNamed(context, "/localnotify")),
                  ListTile(
                      leading: Icon(Icons.menu,
                          size: 20, color: Colors.redAccent),
                      title: Text('Animated Drawer'),
                      onTap: () =>
                          Navigator.pushNamed(context, "/home")),
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
                              entryAnimation: EntryAnimation.LEFT,
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
                          print(value);
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
                      leading: Icon(
                        Icons.date_range,
                        size: 20,
                        color: Color(0XFF2e7d32),
                      ),
                      title: Text('Calendar'),
                      onTap: () => Navigator.pushNamed(context, "/calendarbut")),
                  ListTile(
                      leading: Icon(
                        Icons.text_format,
                        size: 20,
                        color: Color(0XFF9e7e42),
                      ),
                      title: Text('Animate Text'),
                      onTap: () => Navigator.pushNamed(context, "/text")),
                  ListTile(
                      leading: Icon(
                        Icons.volume_up,
                        size: 20,
                        color: Color(0XFF53B032),
                      ),
                      title: Text('Volume Control'),
                      onTap: () =>
                          Navigator.pushNamed(context, "/nativevolume")),
                  ListTile(
                      leading: Icon(
                        Icons.credit_card,
                        size: 20,
                        color: Color(0XFF23F11D),
                      ),
                      title: Text('Card Flip'),
                      onTap: () => Navigator.pushNamed(context, "/flipcard")),
                  ListTile(
                      leading: Icon(
                        Icons.mic,
                        size: 20,
                        color: Color(0XFF892741),
                      ),
                      title: Text('Hey Flutter'),
                      onTap: () =>
                          Navigator.pushNamed(context, "/texttospeech")),
                  ListTile(
                      leading: Icon(
                        Icons.access_alarms,
                        size: 20,
                        color: Color(0XFF892741),
                      ),
                      title: Text('Timer'),
                      onTap: () => Navigator.pushNamed(context, "/time")),
                  ListTile(
                      leading: Icon(
                        Icons.accessibility,
                        size: 20,
                        color: Color(0XFFF062F0),
                      ),
                      title: Text('ADs FLutter'),
                      onTap: () => Navigator.pushNamed(context, "/admob")),
                  ListTile(
                      leading: Icon(
                        Icons.search,
                        size: 20,
                        color: Color(0XFF6262F0),
                      ),
                      title: Text('Search'),
                      onTap: () => Navigator.pushNamed(context, "/country")),
                  ListTile(
                      leading: Icon(
                        Icons.system_update_alt,
                        size: 20,
                        color: Color(0XFF6262F0),
                      ),
                      title: Text('Complex DB'),
                      onTap: () => Navigator.pushNamed(context, "/dbsql")),
                  ListTile(
                      leading: Icon(
                        Icons.table_chart,
                        size: 20,
                        color: Color(0XFF62FFFF),
                      ),
                      title: Text('Simple DB'),
                      onTap: () =>
                          Navigator.pushNamed(context, "/studentmgmr")),
                  ListTile(
                      leading: Icon(
                        Icons.show_chart,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                      title: Text('Draw Anything'),
                      onTap: () => Navigator.pushNamed(context, "/ocrtext")),
                  ListTile(
                      leading: Icon(
                        Icons.fiber_new,
                        size: 20,
                        color: Colors.red[900],
                      ),
                      title: Text('Inshorts'),
                      onTap: () => Navigator.pushNamed(context, "/news")),
                  ListTile(
                      leading: Icon(
                        Icons.speaker_phone,
                        size: 20,
                        color: Colors.red[400],
                      ),
                      title: Text('Tomcat'),
                      onTap: () => Navigator.pushNamed(context, "/voice")),
                  ListTile(
                      leading: Icon(
                        Icons.file_download,
                        size: 20,
                        color: Colors.purpleAccent[400],
                      ),
                      title: Text('Download'),
                      onTap: () => Navigator.pushNamed(context, "/download")),
                  ListTile(
                      leading: Icon(
                        FontAwesomeIcons.tree,
                        size: 20,
                        color: Colors.green[800],
                      ),
                      title: Text('Merry Christmas'),
                      onTap: () => Navigator.pushNamed(context, "/tree")),
                  ListTile(
                      leading: Icon(
                        FontAwesomeIcons.wordpress,
                        size: 20,
                        color: Colors.yellowAccent[800],
                      ),
                      title: Text('Get Synonymn'),
                      onTap: () => Navigator.pushNamed(context, "/word")),
                  ListTile(
                      leading: Icon(
                        FontAwesomeIcons.peopleCarry,
                        size: 20,
                        color: Colors.yellowAccent[800],
                      ),
                      title: Text('Signup'),
                      onTap: () => Navigator.pushNamed(context, "/Signup")),
                  ListTile(
                      leading: Icon(
                        FontAwesomeIcons.stopwatch,
                        size: 20,
                        color: Colors.yellowAccent[800],
                      ),
                      title: Text('Stop Watch'),
                      onTap: () => Navigator.pushNamed(context, "/fasting")),
                  ListTile(
                      leading: Icon(
                        FontAwesomeIcons.calendarDay,
                        size: 20,
                        color: Colors.redAccent[800],
                      ),
                      title: Text('Calendar'),
                      onTap: () => Navigator.pushNamed(context, "/calendar")),
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
    );
  }
}