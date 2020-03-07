import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmartMantra extends StatefulWidget {
  @override
  _SmartMantraState createState() => _SmartMantraState();
}

class _SmartMantraState extends State<SmartMantra> {
  int duration = 1;
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(duration);
    return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            getImageContainer(),
            getControllerContainer()
          ],
        ));
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
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black,
            foregroundColor: Colors.black,
            child: Center(
              child: new Text(
                "  Show   \n Mantra",
                style: TextStyle(color: Colors.white, fontSize: 12),
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
          Text(
            "Count = 3",
            style: TextStyle(color: Colors.white),
          ),
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
                  padding: EdgeInsets.only( top: 10),
                  child: Center(
                    child: GestureDetector(onTap: () {
                      _assetsAudioPlayer.open("assets/shivamantra.mp3");
                      _assetsAudioPlayer.playOrPause();
                    },
                      child: Icon(
                      snapshot.data ? Icons.pause : Icons.play_arrow, size: 90,
                      color: Colors.white,
                    ),
                  )
              ),);
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
            height: 50,
          ),
          Row(
            children: <Widget>[
              Text(
                '         1',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 60,
              ),
              Text(
                '3',
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
                '         5',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 60,
              ),
              Text(
                '10',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
