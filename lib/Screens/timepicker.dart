import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  var Date = '';
  var Time = '';
  bool isON =true;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datetime Picker'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: BorderSide.none,
                ),
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1960, 1, 1),
                      maxTime: DateTime(2100, 12, 31),
                      theme: DatePickerTheme(
                          backgroundColor: Colors.blue,
                          itemStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          doneStyle:
                          TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());
                      },
                      onConfirm: (date) {
                        setState(() {
                          Time = '$date';
                        });
                        print('confirm $date');
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en);
                },
                child: Text(
                  'show date picker ',
                  style: TextStyle(color: Colors.black54),
                )),
            SizedBox(height: 30,),
            FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: BorderSide.none,
                ),
                color: Colors.redAccent,
                onPressed: () {
                  DatePicker.showTimePicker(context, showTitleActions: true,
                      onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        setState(() {
                          Date = '$date';
                        });
                        print('confirm $date');
                      }, currentTime: DateTime.now());
                },
                child: Text(
                  'show time picker',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                )),
            SizedBox(height: 49,),
            Container(
              width: 230,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(new Radius.circular(20.0),)
                ),
                color: Colors.blueAccent,
              ),
              padding: EdgeInsets.all(20),
              child: Text('Selected Time:$Time'),
            ),
            SizedBox(height: 10,),
            Container(
              width: 230,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(new Radius.circular(20.0),)
                ),
                color: Colors.blueAccent,
              ),
              padding: EdgeInsets.all(20),
              child: Text('Selected Date:$Date'),
            ),
            GestureDetector(
              onTap: (){
                switchON();
              },
              child: Container(
                height: 100,
                child: FlareActor(
                    "assets/butt.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                    animation: isON ? "On" : "Off"
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  switchON() {
    debugPrint('hi');
    setState(() {
      isON = !isON;
    });
  }
}