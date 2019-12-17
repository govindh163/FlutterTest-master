import 'package:flutter/material.dart';
import 'dart:async';

class FlutterTimeDemo extends StatefulWidget{
  @override
  _FlutterTimeDemoState createState()=> _FlutterTimeDemoState();

}

class _FlutterTimeDemoState extends State<FlutterTimeDemo>
{
  String _timeString;

  @override
  void initState(){
    _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
     Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Clock'),),
      body:Column(
        children: <Widget>[
          SizedBox(height: 150,),
          Center(
            child: Text(_timeString, style: TextStyle(backgroundColor:Colors.indigoAccent[400],
                fontSize: 50,color: Colors.blue[200]),),
          ),
        ],
      ),
    );
  }

  void _getCurrentTime()  {
  setState(() {    _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";  });
  }
}
