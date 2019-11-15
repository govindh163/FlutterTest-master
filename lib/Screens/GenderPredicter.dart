import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class GenderPredict extends StatefulWidget {
  @override
  _GenderPredictState createState() => _GenderPredictState();
}

class _GenderPredictState extends State<GenderPredict> {
  TextEditingController _nameController = TextEditingController();
  var result='';
 var prob='';
  predictGender(String name) async {
    var url = "https://api.genderize.io/?name=$name";
    var res = await http.get(url);
    var body = jsonDecode(res.body);


    setState(() {
      result = "Gender: ${body['gender']}";
      prob    ="Probability of Prediction: ${body['probability']}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gender Predictor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Enter a name to predict it's gender.",
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                ),
              ),
            ),
            RaisedButton(
              onPressed: () => predictGender(_nameController.text),
              child: Text("Predict"),
            ),
            Container(
              width: 125,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(new Radius.circular(20.0),)
                ),
                color: Colors.blueAccent,
              ),
              padding: EdgeInsets.all(20),
              child: Text(result),
            ),
            Container(
              width: 230,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(new Radius.circular(20.0),)
                ),
                color: Colors.blueAccent,
              ),
              padding: EdgeInsets.all(20),
              child: Text(prob),
            ),
          ],
        ),
      ),
    );
  }
}