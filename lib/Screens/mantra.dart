import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import '../mantraconfig.dart';

class SmartMantra extends StatefulWidget {
  @override
  _SmartMantraState createState() => _SmartMantraState();
}

class _SmartMantraState extends State<SmartMantra> {
  StreamSubscription _positionSubscription;
  Duration position = const Duration();
  Duration totalDur = const Duration(seconds: 0);
  bool isfirstLine = false;
  bool issecondline = false;
  bool isthirdLine = false;
  bool isfourLine = false;
  int count = 0;
  int playTimes = 11;
  bool isshow = false;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  List<Image> images = [
    Image.asset(
      ImageList["0"],
      fit: BoxFit.fill,
    ),
    Image.asset(
      ImageList["1"],
      fit: BoxFit.fill,
    ),
    Image.asset(
      ImageList["2"],
      fit: BoxFit.fill,
    ),
    Image.asset(
      ImageList["3"],
      fit: BoxFit.fill,
    ),
    Image.asset(
      ImageList["4"],
      fit: BoxFit.fill,
    ),
    Image.asset(
      ImageList["5"],
      fit: BoxFit.fill,
    ),
    Image.asset(
      ImageList["6"],
      fit: BoxFit.fill,
    ),
    Image.asset(
      ImageList["7"],
      fit: BoxFit.fill,
    ),
  ];

  addCount() {
    count = count + 1;
    if (count == playTimes + 1) {
      _assetsAudioPlayer.stop();
    }
  }

  stream() {
    _positionSubscription = _assetsAudioPlayer.currentPosition.listen(
          (p) => setState(() => position = p),
    );
  }

  @override
  void initState() {
    _assetsAudioPlayer.open(audioName);
    _getThingsOnStartup().then((value) {
      setState(() {
        totalDur = _assetsAudioPlayer.current.value.duration;
      });
    });
    stream();
    _assetsAudioPlayer.finished.listen((finished) {
      if (count == playTimes) {
        _assetsAudioPlayer.stop();
      }
      if (count < playTimes) {
        addCount();
        Fluttertoast.showToast(msg: "Mantra Playing  $count time");
      }
//      if(count<=playTimes){
//        addCount();
//        Fluttertoast.showToast(msg: "Mantra Played $count times");
//      }
    });
    super.initState();
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    var width = MediaQuery.of(context).size.width;
//    var height= MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            getImageContainer(),
            isshow ? getTextContainer() : getControllerContainer(),
            //getTextContainer()
          ],
        ));
  }

  getTextContainer() {
    return Container(
        height: 180,
        width: 380,
        color: Colors.black,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            getText(isfirstLine,LyricText["1"], 0, 5),
            getText(issecondline,LyricText["2"], 4, 10),
            getText(isthirdLine,LyricText["3"], 9, 15),
            getText(isfourLine, LyricText["4"], 14, 20),
          ],
        ));
  }

  _showMantra() {
    setState(() {
      isshow = !isshow;
    });
  }

  getImageContainer() {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            height: MediaQuery.of(context).size.height-290,
            width: MediaQuery.of(context).size.width-20,
            child: CarouselSlider(
              items: images,
              height:  MediaQuery.of(context).size.height-290,
              aspectRatio: 16 / 9,
              viewportFraction: 2.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              //  autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
            // color: Colors.blue,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height-335,
          child: GestureDetector(
            onTap: _showMantra,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black,
              foregroundColor: Colors.black,
              child: Center(
                child: new Text(
                  " Show  \nMantra",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height-335,
          left: 350,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black,
            foregroundColor: Colors.black,
            child: GestureDetector(
              onTap:  (){
                Share.share('Check out this News App Very Useful https://play.google.com/store/apps/details?id=com.smartiapps.ungalkural&hl=en');
              },
              child: Center(
                child: new Text(
                  "Share",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getControllerContainer() {
    return Container(
      padding: EdgeInsets.only(left: 7),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          repeatMantra(),
          VerticalDivider(
            thickness: 1,
            width: 1,
            color: Colors.blue,
          ),
          getAudio(),
          VerticalDivider(
            thickness: 1,
            width: 1,
            color: Colors.blue,
          ),
          getImageSwitch(),
        ],
      ),
    );
  }

  repeatMantra() {
    return Container(
      height: 180,
      width: 120,
      color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "Repeat Mantra",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Count:$count/$playTimes",
            style: TextStyle(color: Colors.white),
          ),
          //Text(Provider.of<CountProvider>(context).newCount.toString(),style: TextStyle(color: Colors.white),),
          SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RawMaterialButton(
                  onPressed: () => setPlayTimes(11),
                  child: Text("11"),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.red,
                ),
              ),
              Expanded(
                flex: 1,
                child: RawMaterialButton(
                  onPressed: () => setPlayTimes(21),
                  child: Text("21"),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RawMaterialButton(
                  onPressed: () => setPlayTimes(51),
                  child: Text("51"),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.red,
                ),
              ),
              Expanded(
                flex: 1,
                child: RawMaterialButton(
                  onPressed: () => setPlayTimes(108),
                  child: Text("108"),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.red,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  getAudio() {
    return Container(
      height: 180,
      width: 80,
      color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            'Audio',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3,
          ),
          StreamBuilder(
            stream: _assetsAudioPlayer.isPlaying,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return Container(
//                  color: Colors.blue,
                padding: EdgeInsets.only(top: 10),
                child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _assetsAudioPlayer.open(audioName);
                        //    totalDur= _assetsAudioPlayer.current.value.duration;
                        _assetsAudioPlayer.play();
                      },
                      child: Icon(
                        snapshot.data ? Icons.pause : Icons.play_arrow,
                        size: 90,
                        color: Colors.white,
                      ),
                    )),
              );
            },
          ),
          StreamBuilder(
            stream: _assetsAudioPlayer.isPlaying,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return RaisedButton(
                child: Text(snapshot.data ? "Stop" : "Stopped"),
                onPressed: () {
                  _assetsAudioPlayer.stop();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  getImageSwitch() {
    return Container(
      height: 180,
      width:  MediaQuery.of(context).size.width-210,
      color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "Playing Audio",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: _assetsAudioPlayer.currentPosition,
                initialData: const Duration(),
                builder:
                    (BuildContext context, AsyncSnapshot<Duration> snapshot) {
                  Duration duration = snapshot.data;
                  return Text(
                    durationToString(duration),
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  );
                },
              ),
              Text(
                " - ",
                style: TextStyle(color: Colors.white),
              ),
              StreamBuilder(
                  stream: _assetsAudioPlayer.currentPosition,
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
//                      final Duration duration =
//                          asyncSnapshot.data;
                      return Text(
                        durationToString(totalDur),
                        style: TextStyle(color: Colors.red, fontSize: 25),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: _assetsAudioPlayer.isLooping,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return RaisedButton(
                child: Text(snapshot.data
                    ? "Repeat Mantra is  On"
                    : "Repeat Mantra is Off"),
                onPressed: () {
                  _assetsAudioPlayer.toggleLoop();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  getText(bool line, String txt, int low, int high) {
    return StreamBuilder(
      stream: _assetsAudioPlayer.currentPosition,
      initialData: const Duration(),
      builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
        var duration = durationToone(snapshot.data);
        if (duration > low && duration < high) {
          line = true;
        } else {
          line = false;
        }
        return Text(
          txt,
          textScaleFactor: 1.5,
          style: TextStyle(color: line ? Colors.red : Colors.white),
        );
      },
    );
  }

  setPlayTimes(int val) {
    playTimes = val;
    setState(() {});
    print(playTimes);
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes =
  twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  String twoDigitSeconds =
  twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return "$twoDigitMinutes:$twoDigitSeconds";
}

int durationToone(Duration duration) {
  int twoDigits(int n) {
    if (n >= 10) return n;
    return n;
  }

  int twoDigitSeconds =
  twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return twoDigitSeconds;
}
