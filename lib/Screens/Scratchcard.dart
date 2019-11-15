import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

class AppBody extends StatelessWidget {
   int amount = 500;

  Future<void> scratchCardDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              'You\'ve won a scratch card',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          content: StatefulBuilder(builder: (context, StateSetter setState) {

            return Scratcher(
              accuracy: ScratchAccuracy.low,
              threshold: 25,
              brushSize: 60,
              color: Colors.blueAccent,

              child: Container(
                height: 300,
                width: 300,
                alignment: Alignment.center,
                child: Text(
                  "₹ $amount",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.redAccent),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Scratch Card"), backgroundColor: Colors.blue),
      body: Container(
        alignment: Alignment.center,
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide.none,
          ),
          color: Colors.blue,
          child: Text(
            "Get A ScratchCard",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          onPressed: () => scratchCardDialog(context),
        ),
      ),
    );
  }
}