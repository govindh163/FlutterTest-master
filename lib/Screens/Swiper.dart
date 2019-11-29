import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SwiperS extends StatefulWidget {
  @override
  _SwiperSState createState() => _SwiperSState();
}

class _SwiperSState extends State<SwiperS> {

  void showToast() {
    Fluttertoast.showToast(
        msg: DateTime.now().toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Swipe Up to Test"),
      ),

      body: GestureDetector(
        onDoubleTap:showToast ,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              "https://watercart.net/image/cache/catalog/July%20Birthtone%20(3)-1140x380.png",
              fit: BoxFit.fitWidth,
            );
          },
          itemCount: 3,
          scrollDirection: Axis.vertical,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        ),
      ),
    );
  }
}
