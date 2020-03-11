import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SmartMantra extends StatefulWidget {
  @override
  _SmartMantraState createState() => _SmartMantraState();
}

class _SmartMantraState extends State<SmartMantra> {
  StreamSubscription _positionSubscription;
  Duration position;
  bool isfirstLine=false;
  bool issecondline=false;
  bool isthirdLine=false;
  bool isfourLine=false;
  //StreamSubscription _audioPlayerStateSubscription;
  int count = 1;
  bool isshow = false;
  Duration pos;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  List<Image> images = [
    Image.asset(
      "assets/img/a0.png",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assets/img/a1.png",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assets/img/a2.png",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assets/img/a3.png",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assets/img/a4.png",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assets/img/a5.png",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assets/img/a6.png",
      fit: BoxFit.fill,
    ),
    Image.asset(
      "assets/img/a7.png",
      fit: BoxFit.fill,
    ),
  ];
  addCount(){
    setState(() {
      print("hi");
      count=count+1;
      print(count);
    });
  }
  stream(){
    _positionSubscription = _assetsAudioPlayer.currentPosition
        .listen((p) => setState(() => position = p));
  }
  @override
  void initState() {
    _assetsAudioPlayer.open("assets/shivamantra.mp3");
    stream();
    _assetsAudioPlayer.finished.listen((finished) {
      print(finished);
     addCount();
      setTextColor();
//      print(count);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              "Aum Trayambakam Yajamahe",
              textScaleFactor: 1.5,
              style: TextStyle(color:isfirstLine?Colors.red: Colors.white),
            ),
            Text(
              "Sugandhim Pushti Vardhanam",
              textScaleFactor: 1.5,
              style: TextStyle(color:issecondline?Colors.red: Colors.white),
            ),
            Text(
              "Urva Rukamiva Bandhanan",
              textScaleFactor: 1.5,
              style: TextStyle(color:isthirdLine?Colors.red: Colors.white),
            ),
            Text(
              "Mrtyor Muksheeya Maamritat",
              textScaleFactor: 1.5,
              style: TextStyle(color:isfourLine?Colors.red: Colors.white),
            ),
          ],
        ));
  }

  _showMantra() {
    setState(() {
      isshow = !isshow;
    });
  }
  setTextColor(){
    if(durationToone(position)>0 && durationToone(position)<5){
        isfirstLine=true;
    }
    if(durationToone(position)>5 && durationToone(position)<10){
      setState(() {
        issecondline=true;
      });
    }
    if(durationToone(position)>10 && durationToone(position)<15){
      setState(() {
        isthirdLine=true;
      });
    }
    if(durationToone(position)>15 && durationToone(position)<20){
      setState(() {
        isfourLine=true;
      });
    }
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
            height: 583,
            width: 370,
            child: CarouselSlider(
              items: images,
              height: 583,
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
          top: 533,
          child: GestureDetector(
            onTap: _showMantra,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black,
              foregroundColor: Colors.black,
              child: Center(
                child: new Text(
                  durationToone(position).toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 533,
          left: 350,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black,
            foregroundColor: Colors.black,
            child: Center(
              child: new Text(
                "  Share",
                style: TextStyle(color: Colors.white, fontSize: 12),
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
            height: 10,
          ),
         Text("Count:$count",style: TextStyle(color: Colors.white),),
         //Text(Provider.of<CountProvider>(context).newCount.toString(),style: TextStyle(color: Colors.white),),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Text(
                '      11',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                '21',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Text(
                '      51',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                '108',
                style: TextStyle(color: Colors.white),
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
                    _assetsAudioPlayer.open("assets/shivamantra.mp3");
                    _assetsAudioPlayer.playOrPause();
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
            stream: _assetsAudioPlayer.isLooping,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return RaisedButton(
                child: Text(snapshot.data ? "Looping" : "Not looping"),
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

  getImageSwitch() {
    return Container(
      height: 180,
      width: 170,
      color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "Image Switching in Sec",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
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
                    style: TextStyle(color: Colors.white),
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
                      final Duration duration =
                          _assetsAudioPlayer.current.value.duration;
                      return Text(
                        durationToString(duration),
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
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

//Center(
//child: Text(
//"Aum Trayambakam Yajamahe \n Sugandhim Pushti Vardhanam \n  Urva Rukamiva Bandhanan\n Mrtyor Muksheeya Maamritat",
//textScaleFactor: 1.5,
//style: TextStyle(
//color: Colors.white
//),
//),
//),